// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";
import "../interfaces/ITokenExchange.sol";
import "../interfaces/IConnector.sol";
import "../registries/Portfolio.sol";
import "../interfaces/IPriceGetter.sol";

contract AUsdc2A3CrvTokenExchange is ITokenExchange {

    IConnector public curveConnector;
    IERC20 public aUsdcToken;
    IERC20 public a3CrvToken;
    uint256 aUsdcDenominator;
    Portfolio public portfolio;

    constructor(
        address _curveConnector,
        address _aUsdcToken,
        address _a3CrvToken,
        address _portfolio
    ) {
        require(_curveConnector != address(0), "Zero address not allowed");
        require(_aUsdcToken != address(0), "Zero address not allowed");
        require(_a3CrvToken != address(0), "Zero address not allowed");
        require(_portfolio != address(0), "Zero address not allowed");

        curveConnector = IConnector(_curveConnector);
        aUsdcToken = IERC20(_aUsdcToken);
        a3CrvToken = IERC20(_a3CrvToken);
        portfolio = Portfolio(_portfolio);

        aUsdcDenominator = 10 ** (18 - IERC20Metadata(address(aUsdcToken)).decimals());
    }

    
}
