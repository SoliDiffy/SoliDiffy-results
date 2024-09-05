// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";
import "../interfaces/ITokenExchange.sol";
import "../interfaces/IConnector.sol";

contract Usdc2AUsdcTokenExchange is ITokenExchange {
    IConnector public aaveConnector;
    IERC20 public usdcToken;
    IERC20 public aUsdcToken;

    uint256 usdcDenominator;
    uint256 aUsdcDenominator;

    constructor(
        address _aaveConnector,
        address _usdcToken,
        address _aUsdcToken
    ) {
        require(_aaveConnector != address(0), "Zero address not allowed");
        require(_usdcToken != address(0), "Zero address not allowed");
        require(_aUsdcToken != address(0), "Zero address not allowed");

        aaveConnector = IConnector(_aaveConnector);
        usdcToken = IERC20(_usdcToken);
        aUsdcToken = IERC20(_aUsdcToken);

        usdcDenominator = 10 ** (18 - IERC20Metadata(address(usdcToken)).decimals());
        aUsdcDenominator = 10 ** (18 - IERC20Metadata(address(aUsdcToken)).decimals());
    }

    
}
