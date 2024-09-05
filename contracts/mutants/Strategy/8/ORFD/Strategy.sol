// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

import "./GenericLender/IGenericLender.sol";
import "./WantToEthOracle/IWantToEth.sol";

import "@yearnvaults/contracts/BaseStrategy.sol";

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/math/Math.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/token/ERC20/SafeERC20.sol";

interface IUni {
    function getAmountsOut(uint256 amountIn, address[] calldata path) external view returns (uint256[] memory amounts);
}

/********************
 *
 *   A lender optimisation strategy for any erc20 asset
 *   https://github.com/Grandthrax/yearnV2-generic-lender-strat
 *   v0.2.2
 *
 *   This strategy works by taking plugins designed for standard lending platforms
 *   It automatically chooses the best yield generating platform and adjusts accordingly
 *   The adjustment is sub optimal so there is an additional option to manually set position
 *
 ********************* */

contract Strategy is BaseStrategy {
    using SafeERC20 for IERC20;
    using Address for address;
    using SafeMath for uint256;

    address public constant uniswapRouter = address(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D);
    address public constant weth = address(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);

    IGenericLender[] public lenders;
    bool public externalOracle = false;
    address public wantToEthOracle;

    constructor(address _vault) public BaseStrategy(_vault) {
        debtThreshold = 1000;

        //we do this horrible thing because you can't compare strings in solidity
        require(keccak256(bytes(apiVersion())) == keccak256(bytes(VaultAPI(_vault).apiVersion())), "WRONG VERSION");
    }

    function setPriceOracle(address _oracle) external onlyAuthorized {
        wantToEthOracle = _oracle;
    }

    

    //management functions
    //add lenders for the strategy to choose between
    // only governance to stop strategist adding dodgy lender
    function addLender(address a) public onlyGovernance {
        IGenericLender n = IGenericLender(a);
        require(n.strategy() == address(this), "Undocked Lender");

        for (uint256 i = 0; i < lenders.length; i++) {
            require(a != address(lenders[i]), "Already Added");
        }
        lenders.push(n);
    }

    //but strategist can remove for safety
    function safeRemoveLender(address a) public onlyAuthorized {
        _removeLender(a, false);
    }

    function forceRemoveLender(address a) public onlyAuthorized {
        _removeLender(a, true);
    }

    //force removes the lender even if it still has a balance
    function _removeLender(address a, bool force) internal {
        for (uint256 i = 0; i < lenders.length; i++) {
            if (a == address(lenders[i])) {
                bool allWithdrawn = lenders[i].withdrawAll();

                if (!force) {
                    require(allWithdrawn, "WITHDRAW FAILED");
                }

                //put the last index here
                //remove last index
                if (i != lenders.length - 1) {
                    lenders[i] = lenders[lenders.length - 1];
                }

                //pop shortens array by 1 thereby deleting the last index
                lenders.pop();

                //if balance to spend we might as well put it into the best lender
                if (want.balanceOf(address(this)) > 0) {
                    adjustPosition(0);
                }
                return;
            }
        }
        require(false, "NOT LENDER");
    }

    //we could make this more gas efficient but it is only used by a view function
    struct lendStatus {
        string name;
        uint256 assets;
        uint256 rate;
        address add;
    }

    //Returns the status of all lenders attached the strategy
    function lendStatuses() public view returns (lendStatus[] memory) {
        lendStatus[] memory statuses = new lendStatus[](lenders.length);
        for (uint256 i = 0; i < lenders.length; i++) {
            lendStatus memory s;
            s.name = lenders[i].lenderName();
            s.add = address(lenders[i]);
            s.assets = lenders[i].nav();
            s.rate = lenders[i].apr();
            statuses[i] = s;
        }

        return statuses;
    }

    // lent assets plus loose assets
    

    function numLenders() public view returns (uint256) {
        return lenders.length;
    }

    //the weighted apr of all lenders. sum(nav * apr)/totalNav
    function estimatedAPR() public view returns (uint256) {
        uint256 bal = estimatedTotalAssets();
        if (bal == 0) {
            return 0;
        }

        uint256 weightedAPR = 0;

        for (uint256 i = 0; i < lenders.length; i++) {
        // SWC-101-Integer Overflow and Underflow: L157
            weightedAPR += lenders[i].weightedApr();
        }

        return weightedAPR.div(bal);
    }

    //Estimates the impact on APR if we add more money. It does not take into account adjusting position
    function _estimateDebtLimitIncrease(uint256 change) internal view returns (uint256) {
        uint256 highestAPR = 0;
        uint256 aprChoice = 0;
        uint256 assets = 0;

        for (uint256 i = 0; i < lenders.length; i++) {
            uint256 apr = lenders[i].aprAfterDeposit(change);
            if (apr > highestAPR) {
                aprChoice = i;
                highestAPR = apr;
                assets = lenders[i].nav();
            }
        }

        uint256 weightedAPR = highestAPR.mul(assets.add(change));

        for (uint256 i = 0; i < lenders.length; i++) {
            if (i != aprChoice) {
            // SWC-101-Integer Overflow and Underflow: L183
                weightedAPR += lenders[i].weightedApr();
            }
        }

        uint256 bal = estimatedTotalAssets().add(change);

        return weightedAPR.div(bal);
    }

    //Estimates debt limit decrease. It is not accurate and should only be used for very broad decision making
    function _estimateDebtLimitDecrease(uint256 change) internal view returns (uint256) {
        uint256 lowestApr = uint256(-1);
        uint256 aprChoice = 0;

        for (uint256 i = 0; i < lenders.length; i++) {
            uint256 apr = lenders[i].aprAfterDeposit(change);
            if (apr < lowestApr) {
                aprChoice = i;
                lowestApr = apr;
            }
        }

        uint256 weightedAPR = 0;

        for (uint256 i = 0; i < lenders.length; i++) {
            if (i != aprChoice) {
                // SWC-101-Integer Overflow and Underflow: L210
                weightedAPR += lenders[i].weightedApr();
            } else {
                uint256 asset = lenders[i].nav();
                if (asset < change) {
                    //simplistic. not accurate
                    change = asset;
                }
                // SWC-101-Integer Overflow and Underflow: 218
                weightedAPR += lowestApr.mul(change);
            }
        }
        uint256 bal = estimatedTotalAssets().add(change);
        return weightedAPR.div(bal);
    }

    //estimates highest and lowest apr lenders. Public for debugging purposes but not much use to general public
    function estimateAdjustPosition()
        public
        view
        returns (
            uint256 _lowest,
            uint256 _lowestApr,
            uint256 _highest,
            uint256 _potential
        )
    {
        //all loose assets are to be invested
        uint256 looseAssets = want.balanceOf(address(this));

        // our simple algo
        // get the lowest apr strat
        // cycle through and see who could take its funds plus want for the highest apr
        _lowestApr = uint256(-1);
        _lowest = 0;
        uint256 lowestNav = 0;
        for (uint256 i = 0; i < lenders.length; i++) {
            if (lenders[i].hasAssets()) {
                uint256 apr = lenders[i].apr();
                if (apr < _lowestApr) {
                    _lowestApr = apr;
                    _lowest = i;
                    lowestNav = lenders[i].nav();
                }
            }
        }

        uint256 toAdd = lowestNav.add(looseAssets);

        uint256 highestApr = 0;
        _highest = 0;

        for (uint256 i = 0; i < lenders.length; i++) {
            uint256 apr;
            apr = lenders[i].aprAfterDeposit(looseAssets);

            if (apr > highestApr) {
                highestApr = apr;
                _highest = i;
            }
        }

        //if we can improve apr by withdrawing we do so
        _potential = lenders[_highest].aprAfterDeposit(toAdd);
    }

    //gives estiomate of future APR with a change of debt limit. Useful for governance to decide debt limits
    function estimatedFutureAPR(uint256 newDebtLimit) public view returns (uint256) {
        uint256 oldDebtLimit = vault.strategies(address(this)).totalDebt;
        uint256 change;
        if (oldDebtLimit < newDebtLimit) {
            change = newDebtLimit - oldDebtLimit;
            return _estimateDebtLimitIncrease(change);
        } else {
            change = oldDebtLimit - newDebtLimit;
            return _estimateDebtLimitDecrease(change);
        }
    }

    //cycle all lenders and collect balances
    function lentTotalAssets() public view returns (uint256) {
        uint256 nav = 0;
        for (uint256 i = 0; i < lenders.length; i++) {
            // SWC-101-Integer Overflow and Underflow: 293
            nav += lenders[i].nav();
        }
        return nav;
    }

    //we need to free up profit plus _debtOutstanding.
    //If _debtOutstanding is more than we can free we get as much as possible
    // should be no way for there to be a loss. we hope...
    

    /*
     * Key logic.
     *   The algorithm moves assets from lowest return to highest
     *   like a very slow idiots bubble sort
     *   we ignore debt outstanding for an easy life
     */
    

    struct lenderRatio {
        address lender;
        //share x 1000
        uint16 share;
    }

    //share must add up to 1000.
    function manualAllocation(lenderRatio[] memory _newPositions) public onlyAuthorized {
        uint256 share = 0;

        // SWC-128-DoS With Block Gas Limit: L421 - L424
        for (uint256 i = 0; i < lenders.length; i++) {
            // SWC-104-Unchecked Call Return Value: L422
            lenders[i].withdrawAll();
        }

        uint256 assets = want.balanceOf(address(this));

        for (uint256 i = 0; i < _newPositions.length; i++) {
            bool found = false;

            //might be annoying and expensive to do this second loop but worth it for safety
            for (uint256 j = 0; j < lenders.length; j++) {
                if (address(lenders[j]) == _newPositions[j].lender) {
                    found = true;
                }
            }
            require(found, "NOT LENDER");

            // SWC-101-Integer Overflow and Underflow: 437
            share += _newPositions[i].share;
            uint256 toSend = assets.mul(_newPositions[i].share).div(1000);
            want.safeTransfer(_newPositions[i].lender, toSend);
            IGenericLender(_newPositions[i].lender).deposit();
        }

        require(share == 1000, "SHARE!=1000");
    }

    //cycle through withdrawing from worst rate first
    function _withdrawSome(uint256 _amount) internal returns (uint256 amountWithdrawn) {
        //dont withdraw dust
        if (_amount < debtThreshold) {
            return 0;
        }

        amountWithdrawn = 0;
        //most situations this will only run once. Only big withdrawals will be a gas guzzler
        uint256 j = 0;
        while (amountWithdrawn < _amount) {
            uint256 lowestApr = uint256(-1);
            uint256 lowest = 0;
            for (uint256 i = 0; i < lenders.length; i++) {
                if (lenders[i].hasAssets()) {
                    uint256 apr = lenders[i].apr();
                    if (apr < lowestApr) {
                        lowestApr = apr;
                        lowest = i;
                    }
                }
            }
            if (!lenders[lowest].hasAssets()) {
                return amountWithdrawn;
            }
            // SWC-101-Integer Overflow and Underflow: 472
            amountWithdrawn += lenders[lowest].withdraw(_amount - amountWithdrawn);
            j++;
            //dont want infinite loop
            if (j >= 6) {
                return amountWithdrawn;
            }
        }
    }

    /*
     * Liquidate as many assets as possible to `want`, irregardless of slippage,
     * up to `_amountNeeded`. Any excess should be re-invested here as well.
     */
    

    

    function ethToWant(uint256 _amount) internal view returns (uint256) {
        address[] memory path = new address[](2);
        path = new address[](2);
        path[0] = weth;
        path[1] = address(want);

        uint256[] memory amounts = IUni(uniswapRouter).getAmountsOut(_amount, path);

        return amounts[amounts.length - 1];
    }

    function _callCostToWant(uint256 callCost) internal view returns (uint256) {
        uint256 wantCallCost;

        //three situations
        //1 currency is eth so no change.
        //2 we use uniswap swap price
        //3 we use external oracle
        if (address(want) == weth) {
            wantCallCost = callCost;
        } else if (wantToEthOracle == address(0)) {
            wantCallCost = ethToWant(callCost);
        } else {
            wantCallCost = IWantToEth(wantToEthOracle).ethToWant(callCost);
        }

        return wantCallCost;
    }

    

    /*
     * revert if we can't withdraw full balance
     */
    

    function protectedTokens() internal view override returns (address[] memory) {
        address[] memory protected = new address[](1);
        protected[0] = address(want);
        return protected;
    }
}
