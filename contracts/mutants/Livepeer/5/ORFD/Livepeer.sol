// SPDX-FileCopyrightText: 2021 Tenderize <info@tenderize.me>

// SPDX-License-Identifier: MIT

pragma solidity 0.8.4;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "../../../libs/MathUtils.sol";

import "../../Tenderizer.sol";
import "./ILivepeer.sol";

import "../../WithdrawalLocks.sol";

import "../../../interfaces/IWETH.sol";
import "../../../interfaces/ISwapRouter.sol";

import { ITenderSwapFactory } from "../../../tenderswap/TenderSwapFactory.sol";

contract Livepeer is Tenderizer {
    using WithdrawalLocks for WithdrawalLocks.Locks;

    uint256 private constant MAX_ROUND = 2**256 - 1;

    IWETH private WETH;
    ISwapRouterWithWETH public uniswapRouter;
    uint24 private constant UNISWAP_POOL_FEE = 10000;

    ILivepeer livepeer;

    uint256 private constant ethFees_threshold = 1**17;

    WithdrawalLocks.Locks withdrawLocks;

    function initialize(
        IERC20 _steak,
        string calldata _symbol,
        ILivepeer _livepeer,
        address _node,
        uint256 _protocolFee,
        uint256 _liquidityFee,
        ITenderToken _tenderTokenTarget,
        TenderFarmFactory _tenderFarmFactory,
        ITenderSwapFactory _tenderSwapFactory
    ) public {
        Tenderizer._initialize(
            _steak,
            _symbol,
            _node,
            _protocolFee,
            _liquidityFee,
            _tenderTokenTarget,
            _tenderFarmFactory,
            _tenderSwapFactory
        );
        livepeer = _livepeer;
    }

    

    

    // TODO: is unstaking when front running a negative rebase exploitable ?
    

    

    /**
     * @notice claims secondary rewards
     * these are rewards that are not from staking
     * but from fees that do not directly accumulate
     * towards stake. These could either be liquid
     * underlying tokens, or other tokens that then
     * need to be swapped using a DEX.
     * Secondary claimed fees will be immeadiatly
     * added to the balance of this contract
     * @dev this is implementation specific
     */
    function _claimSecondaryRewards() internal {
        uint256 ethFees = livepeer.pendingFees(address(this), MAX_ROUND);
        // First claim any fees that are not underlying tokens
        // withdraw fees
        if (ethFees >= ethFees_threshold) {
            livepeer.withdrawFees();

            // Wrap ETH
            uint256 bal = address(this).balance;
            WETH.deposit{ value: bal }();
            WETH.approve(address(uniswapRouter), bal);

            // swap ETH fees for LPT
            if (address(uniswapRouter) != address(0)) {
                ISwapRouter.ExactInputSingleParams memory params = ISwapRouter.ExactInputSingleParams({
                    tokenIn: address(WETH),
                    tokenOut: address(steak),
                    fee: UNISWAP_POOL_FEE,
                    recipient: address(this),
                    deadline: block.timestamp,
                    amountIn: bal,
                    amountOutMinimum: 0, // TODO: Set5% max slippage
                    sqrtPriceLimitX96: 0
                });
                // SWC-104-Unchecked Call Return Value: L162 - L164
                try uniswapRouter.exactInputSingle(params) returns (
                    uint256 /*_swappedLPT*/
                ) {} catch {}
            }
        }
    }

    

    function _setStakingContract(address _stakingContract) internal override {
        livepeer = ILivepeer(_stakingContract);

        emit GovernanceUpdate("STAKING_CONTRACT");
    }

    function setUniswapRouter(address _uniswapRouter) external onlyGov {
        uniswapRouter = ISwapRouterWithWETH(_uniswapRouter);
        WETH = IWETH(uniswapRouter.WETH9());
    }
}
