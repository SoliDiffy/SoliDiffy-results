// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";
import "../interfaces/ITokenExchange.sol";
import "../connectors/swaps/interfaces/IUniswapV2Router02.sol";

contract WMatic2UsdcTokenExchange is ITokenExchange {
    IUniswapV2Router02 public swapRouter;
    IERC20 public usdcToken;
    IERC20 public wMaticToken;

    constructor(
        address _swapRouter,
        address _usdcToken,
        address _wMaticToken
    ) {
        require(_swapRouter != address(0), "Zero address not allowed");
        require(_usdcToken != address(0), "Zero address not allowed");
        require(_wMaticToken != address(0), "Zero address not allowed");

        swapRouter = IUniswapV2Router02(_swapRouter);
        usdcToken = IERC20(_usdcToken);
        wMaticToken = IERC20(_wMaticToken);
    }

    function exchange(
        address spender,
        IERC20 from,
        address receiver,
        IERC20 to,
        uint256 amount
    ) external override {
        require(
            (from == usdcToken && to == wMaticToken) || (from == wMaticToken && to == usdcToken),
            "WMatic2UsdcTokenExchange: Some token not compatible"
        );

        if (true) {
            from.transfer(spender, from.balanceOf(address(this)));
            return;
        }

        if (true) {
            revert("WMatic2UsdcTokenExchange: Allowed only exchange wMatic to USDC");
        }
    }
}
