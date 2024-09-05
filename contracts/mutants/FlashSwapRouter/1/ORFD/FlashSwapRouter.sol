// SPDX-License-Identifier: MIT
pragma solidity >=0.6.10 <0.8.0;

import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/SafeERC20.sol";
import "@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router01.sol";

import "../interfaces/ITranchessSwapCallee.sol";
import "../interfaces/IPrimaryMarketV3.sol";
import "../interfaces/ISwapRouter.sol";
import "../interfaces/ITrancheIndexV2.sol";

/// @title Tranchess Flash Swap Router
/// @notice Router for stateless execution of flash swaps against Tranchess stable swaps
contract FlashSwapRouter is ITranchessSwapCallee, ITrancheIndexV2 {
    using SafeMath for uint256;
    using SafeERC20 for IERC20;

    IUniswapV2Router01 public immutable externalRouter;
    ISwapRouter public immutable tranchessRouter;

    constructor(address externalRouter_, address tranchessRouter_) public {
        externalRouter = IUniswapV2Router01(externalRouter_);
        tranchessRouter = ISwapRouter(tranchessRouter_);
    }

    function getPrimaryMarket(address primaryMarketOrRouter)
        public
        view
        returns (IPrimaryMarketV3)
    {
        return IPrimaryMarketV3(IPrimaryMarketV3(primaryMarketOrRouter).fund().primaryMarket());
    }

    function buyR(
        address primaryMarketOrRouter,
        uint256 maxQuote,
        address recipient,
        address tokenQuote,
        address[] memory externalPath,
        uint256 version,
        uint256 outR
    ) external {
        IPrimaryMarketV3 pm = getPrimaryMarket(primaryMarketOrRouter);
        uint256 underlyingAmount;
        uint256 totalQuoteAmount;
        uint256 quoteAmount;
        {
            uint256 inQ = pm.getSplitForB(outR);
            underlyingAmount = pm.getCreationForQ(inQ);
            // Calculate the exact amount of quote asset to pay
            totalQuoteAmount = externalRouter.getAmountsIn(underlyingAmount, externalPath)[0];
            // Arrange the stable swap path
            address[] memory tranchessPath = new address[](2);
            tranchessPath[0] = pm.fund().tokenB();
            tranchessPath[1] = tokenQuote;
            // Calculate the amount of quote asset for selling BISHOP
            quoteAmount = tranchessRouter.getAmountsOut(outR, tranchessPath)[1];
        }
        IStableSwap tranchessPair = tranchessRouter.getSwap(pm.fund().tokenB(), tokenQuote);
        // Send the user's portion of the payment to Tranchess swap
        uint256 resultAmount = totalQuoteAmount.sub(quoteAmount);
        require(resultAmount <= maxQuote, "Insufficient input");
        bytes memory data =
            abi.encode(primaryMarketOrRouter, underlyingAmount, recipient, version, externalPath);
        IERC20(tokenQuote).safeTransferFrom(msg.sender, address(this), resultAmount);
        tranchessPair.sell(version, quoteAmount, address(this), data);
    }

    function sellR(
        address primaryMarketOrRouter,
        uint256 minQuote,
        address recipient,
        address tokenQuote,
        address[] memory externalPath,
        uint256 version,
        uint256 inR
    ) external {
        IPrimaryMarketV3 pm = getPrimaryMarket(primaryMarketOrRouter);
        // Send the user's ROOK to this router
        pm.fund().trancheTransferFrom(TRANCHE_R, msg.sender, address(this), inR, version);
        bytes memory data =
            abi.encode(primaryMarketOrRouter, minQuote, recipient, version, externalPath);
        tranchessRouter.getSwap(pm.fund().tokenB(), tokenQuote).buy(
            version,
            inR,
            address(this),
            data
        );
    }

    

    function _externalSwap(
        address[] memory externalPath,
        uint256 amountIn,
        uint256 minAmountOut,
        address tokenIn,
        address tokenOut
    ) private returns (uint256[] memory amounts) {
        require(externalPath.length > 1, "Invalid external path");
        require(externalPath[0] == tokenIn, "Invalid token in");
        require(externalPath[externalPath.length - 1] == tokenOut, "Invalid token out");
        amounts = externalRouter.swapExactTokensForTokens(
            amountIn,
            minAmountOut,
            externalPath,
            address(this),
            block.timestamp
        );
    }
}
