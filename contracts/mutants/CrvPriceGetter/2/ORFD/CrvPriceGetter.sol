// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "../price_getters/AbstractPriceGetter.sol";
import "../connectors/swaps/interfaces/IUniswapV2Router02.sol";

contract CrvPriceGetter is AbstractPriceGetter {
    IUniswapV2Router02 public swapRouter;
    IERC20 public usdcToken;
    IERC20 public crvToken;

    constructor(
        address _swapRouter,
        address _usdcToken,
        address _crvToken
    ) {
        require(_swapRouter != address(0), "Zero address not allowed");
        require(_usdcToken != address(0), "Zero address not allowed");
        require(_crvToken != address(0), "Zero address not allowed");

        swapRouter = IUniswapV2Router02(_swapRouter);
        usdcToken = IERC20(_usdcToken);
        crvToken = IERC20(_crvToken);
    }

    

    
}
