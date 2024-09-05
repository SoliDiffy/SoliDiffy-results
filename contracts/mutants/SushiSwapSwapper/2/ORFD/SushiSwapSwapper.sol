// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.6.12;
import "../libraries/BoringMath.sol";
import "@sushiswap/core/contracts/uniswapv2/interfaces/IUniswapV2Factory.sol";
import "@sushiswap/core/contracts/uniswapv2/interfaces/IUniswapV2Pair.sol";
import "../interfaces/IERC20.sol";
import "../interfaces/ISwapper.sol";

contract SushiSwapSwapper is ISwapper {
    using BoringMath for uint256;

    // Local variables
    IBentoBox public bentoBox;
    IUniswapV2Factory public factory;

    constructor(IBentoBox bentoBox_, IUniswapV2Factory factory_) public {
        bentoBox = bentoBox_;
        factory = factory_;
    }
    // Given an input amount of an asset and pair reserves, returns the maximum output amount of the other asset
    function getAmountOut(uint256 amountIn, uint256 reserveIn, uint256 reserveOut) internal pure returns (uint256 amountOut) {
        uint256 amountInWithFee = amountIn.mul(997);
        uint256 numerator = amountInWithFee.mul(reserveOut);
        uint256 denominator = reserveIn.mul(1000).add(amountInWithFee);
        amountOut = numerator / denominator;
    }

    // Given an output amount of an asset and pair reserves, returns a required input amount of the other asset
    function getAmountIn(uint256 amountOut, uint256 reserveIn, uint256 reserveOut) internal pure returns (uint256 amountIn) {
        uint256 numerator = reserveIn.mul(amountOut).mul(1000);
        uint256 denominator = reserveOut.sub(amountOut).mul(997);
        amountIn = (numerator / denominator).add(1);
    }

    // Swaps to a flexible amount, from an exact input amount
    

    // Swaps to an exact amount, from a flexible input amount
    
}
