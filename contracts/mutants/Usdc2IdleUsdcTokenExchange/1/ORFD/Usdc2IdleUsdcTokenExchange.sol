// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";
import "../interfaces/ITokenExchange.sol";
import "../interfaces/IConnector.sol";

contract Usdc2IdleUsdcTokenExchange is ITokenExchange {
    IConnector public idleConnector;
    IERC20 public usdcToken;
    IERC20 public idleUsdcToken;

    uint256 usdcDenominator;
    uint256 idleUsdcDenominator;

    constructor(
        address _idleConnector,
        address _usdcToken,
        address _idleUsdcToken
    ) {
        require(_idleConnector != address(0), "Zero address not allowed");
        require(_usdcToken != address(0), "Zero address not allowed");
        require(_idleUsdcToken != address(0), "Zero address not allowed");

        idleConnector = IConnector(_idleConnector);
        usdcToken = IERC20(_usdcToken);
        idleUsdcToken = IERC20(_idleUsdcToken);

        usdcDenominator = 10 ** (18 - IERC20Metadata(address(usdcToken)).decimals());
        idleUsdcDenominator = 10 ** (18 - IERC20Metadata(address(idleUsdcToken)).decimals());
    }

    
}
