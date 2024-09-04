// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/token/ERC20/SafeERC20.sol";

import "../Interfaces/alpha-homora/Bank.sol";
import "../Interfaces/alpha-homora/BankConfig.sol";
import "../Interfaces/UniswapInterfaces/IWETH.sol";

import "./GenericLenderBase.sol";

/********************
 *   A lender plugin for LenderYieldOptimiser for any erc20 asset on Cream (not eth)
 *   Made by SamPriestley.com
 *   https://github.com/Grandthrax/yearnv2/blob/master/contracts/GenericLender/GenericCream.sol
 *
 ********************* */

contract AlphaHomo is GenericLenderBase {
    using SafeERC20 for IERC20;
    using Address for address;
    using SafeMath for uint256;

    uint256 private constant secondsPerYear = 31556952;
    address public constant weth = address(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);
    address public constant bank = address(0x67B66C99D3Eb37Fa76Aa3Ed1ff33E8e39F0b9c7A);

    constructor(address _strategy, string memory name) public GenericLenderBase(_strategy, name) {
        require(address(want) == weth, "NOT WETH");
        dust = 1e12;
        //want.approve(_cToken, uint256(-1));
    }

    receive() external payable {}

    

    function _nav() internal view returns (uint256) {
        return want.balanceOf(address(this)).add(underlyingBalanceStored());
    }

    function withdrawUnderlying(uint256 amount) internal returns (uint256) {
        Bank b = Bank(bank);

        uint256 shares = amount.mul(b.totalSupply()).div(_bankTotalEth());
        //uint256 shares = amount.mul(b.glbDebtVal().add(b.pendingInterest(0))).div(b.glbDebtShare());
        // uint256 shares = b.debtValToShare(amount);
        uint256 balance = b.balanceOf(address(this));
        if (shares > balance) {
            b.withdraw(balance);
        } else {
            b.withdraw(shares);
        }

        uint256 withdrawn = address(this).balance;
        IWETH(weth).deposit{value: withdrawn}();

        return withdrawn;
    }

    function underlyingBalanceStored() public view returns (uint256 balance) {
        Bank b = Bank(bank);
        return b.balanceOf(address(this)).mul(_bankTotalEth()).div(b.totalSupply());
        //return b.balanceOf(address(this)).mul(b.glbDebtVal().add(b.pendingInterest(0))).div(b.glbDebtShare());
    }

    function _bankTotalEth() internal view returns (uint256 _totalEth) {
        Bank b = Bank(bank);

        uint256 interest = b.pendingInterest(0);
        BankConfig config = BankConfig(b.config());
        uint256 toReserve = interest.mul(config.getReservePoolBps()).div(10000);

        uint256 glbDebtVal = b.glbDebtVal().add(interest);
        uint256 reservePool = b.reservePool().add(toReserve);

        _totalEth = bank.balance.add(glbDebtVal).sub(reservePool);
    }

    

    

    function _apr(uint256 amount) internal view returns (uint256) {
        Bank b = Bank(bank);
        BankConfig config = BankConfig(b.config());
        uint256 balance = bank.balance.add(amount);
        uint256 ratePerSec = config.getInterestRate(b.glbDebtVal(), balance);

        return ratePerSec.mul(secondsPerYear);
    }

    

    

    //emergency withdraw. sends balance plus amount to governance
    

    //withdraw an amount including any want balance
    function _withdraw(uint256 amount) internal returns (uint256) {
        uint256 balanceUnderlying = underlyingBalanceStored();
        uint256 looseBalance = want.balanceOf(address(this));
        uint256 total = balanceUnderlying.add(looseBalance);

        if (amount > total) {
            //cant withdraw more than we own
            amount = total;
        }
        if (looseBalance >= amount) {
            want.safeTransfer(address(strategy), amount);
            return amount;
        }

        //not state changing but OK because of previous call
        uint256 liquidity = bank.balance;

        if (liquidity > 1) {
            uint256 toWithdraw = amount.sub(looseBalance);

            if (toWithdraw <= liquidity) {
                //we can take all
                withdrawUnderlying(toWithdraw);
            } else {
                //take all we can
                withdrawUnderlying(liquidity);
            }
        }
        looseBalance = want.balanceOf(address(this));
        want.safeTransfer(address(strategy), looseBalance);
        return looseBalance;
    }

    

    

    //think about this
    function enabled() external view override returns (bool) {
        return true;
    }

    function hasAssets() external view override returns (bool) {
        uint256 bankBal = Bank(bank).balanceOf(address(this));
        uint256 wantBal = want.balanceOf(address(this));

        //adding apples to oranges but doesnt matter as we are just looking for rounding errors
        return bankBal.add(wantBal) > dust;
    }

    function protectedTokens() internal view override returns (address[] memory) {
        address[] memory protected = new address[](2);
        protected[0] = address(want);
        protected[1] = bank;
        return protected;
    }
}
