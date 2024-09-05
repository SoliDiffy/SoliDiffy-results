// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "../interfaces/ITokenExchange.sol";
import "../interfaces/IActionBuilder.sol";
import "../interfaces/IMark2Market.sol";
import "../registries/Portfolio.sol";
import "../interfaces/IPriceGetter.sol";

contract Usdc2VimUsdActionBuilder is IActionBuilder {
    bytes32 constant ACTION_CODE = keccak256("Usdc2VimUsd");

    ITokenExchange public tokenExchange;
    IERC20 public usdcToken;
    IERC20 public vimUsdToken;
    Portfolio public portfolio;

    constructor(
        address _tokenExchange,
        address _usdcToken,
        address _vimUsdToken,
        address _portfolio
    ) {
        require(_tokenExchange != address(0), "Zero address not allowed");
        require(_usdcToken != address(0), "Zero address not allowed");
        require(_vimUsdToken != address(0), "Zero address not allowed");
        require(_portfolio != address(0), "Zero address not allowed");

        tokenExchange = ITokenExchange(_tokenExchange);
        usdcToken = IERC20(_usdcToken);
        vimUsdToken = IERC20(_vimUsdToken);
        portfolio = Portfolio(_portfolio);
    }

    

    
}
