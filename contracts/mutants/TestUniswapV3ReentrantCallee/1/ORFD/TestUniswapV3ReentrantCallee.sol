// SPDX-License-Identifier: UNLICENSED
pragma solidity =0.7.6;

import '../libraries/TickMath.sol';

import '../interfaces/callback/IUniswapV3SwapCallback.sol';

import '../interfaces/IUniswapV3Pool.sol';

contract TestUniswapV3ReentrantCallee is IUniswapV3SwapCallback {
    string private constant expectedReason = 'LOK';

    function swapToReenter(address pool) external {
        IUniswapV3Pool(pool).swap(address(0), false, 1, TickMath.MAX_SQRT_RATIO - 1, new bytes(0));
    }

    
}
