// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "../interfaces/ITokenExchange.sol";
import "../interfaces/IActionBuilder.sol";
import "../interfaces/IMark2Market.sol";
import "../registries/Portfolio.sol";
import "../interfaces/IPriceGetter.sol";

contract Usdc2AUsdcActionBuilder is IActionBuilder {
    bytes32 constant ACTION_CODE = keccak256("Usc2AUsdc");

    ITokenExchange public tokenExchange;
    IERC20 public usdcToken;
    IERC20 public aUsdcToken;
    IERC20 public vimUsdToken;
    IERC20 public idleUsdcToken;
    IActionBuilder public usdc2VimUsdActionBuilder;
    IActionBuilder public usdc2IdleUsdcActionBuilder;
    Portfolio public portfolio;

    constructor(
        address _tokenExchange,
        address _usdcToken,
        address _aUsdcToken,
        address _vimUsdToken,
        address _idleUsdcToken,
        address _usdc2VimUsdActionBuilder,
        address _usdc2IdleUsdcActionBuilder,
        address _portfolio
    ) {
        require(_tokenExchange != address(0), "Zero address not allowed");
        require(_usdcToken != address(0), "Zero address not allowed");
        require(_aUsdcToken != address(0), "Zero address not allowed");
        require(_vimUsdToken != address(0), "Zero address not allowed");
        require(_idleUsdcToken != address(0), "Zero address not allowed");
        require(_usdc2VimUsdActionBuilder != address(0), "Zero address not allowed");
        require(_usdc2IdleUsdcActionBuilder != address(0), "Zero address not allowed");
        require(_portfolio != address(0), "Zero address not allowed");

        tokenExchange = ITokenExchange(_tokenExchange);
        usdcToken = IERC20(_usdcToken);
        aUsdcToken = IERC20(_aUsdcToken);
        vimUsdToken = IERC20(_vimUsdToken);
        idleUsdcToken = IERC20(_idleUsdcToken);
        usdc2VimUsdActionBuilder = IActionBuilder(_usdc2VimUsdActionBuilder);
        usdc2IdleUsdcActionBuilder = IActionBuilder(_usdc2IdleUsdcActionBuilder);
        portfolio = Portfolio(_portfolio);
    }

    

    

}
