// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "../interfaces/ITokenExchange.sol";
import "../interfaces/IActionBuilder.sol";
import "../interfaces/IMark2Market.sol";

contract A3Crv2A3CrvGaugeActionBuilder is IActionBuilder {
    bytes32 constant ACTION_CODE = keccak256("A3Crv2A3CrvGauge");

    ITokenExchange public tokenExchange;
    IERC20 public a3CrvToken;
    IERC20 public a3CrvGaugeToken;

    constructor(
        address _tokenExchange,
        address _a3CrvToken,
        address _a3CrvGaugeToken
    ) {
        require(_tokenExchange != address(0), "Zero address not allowed");
        require(_a3CrvToken != address(0), "Zero address not allowed");
        require(_a3CrvGaugeToken != address(0), "Zero address not allowed");

        tokenExchange = ITokenExchange(_tokenExchange);
        a3CrvToken = IERC20(_a3CrvToken);
        a3CrvGaugeToken = IERC20(_a3CrvGaugeToken);
    }

    

    
}
