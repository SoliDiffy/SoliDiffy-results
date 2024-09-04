// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "../interfaces/ITokenExchange.sol";
import "../interfaces/IActionBuilder.sol";
import "../interfaces/IMark2Market.sol";

contract Crv2UsdcActionBuilder is IActionBuilder {
    bytes32 constant ACTION_CODE = keccak256("Crv2Usdc");

    ITokenExchange public tokenExchange;
    IERC20 public usdcToken;
    IERC20 public crvToken;

    constructor(
        address _tokenExchange,
        address _usdcToken,
        address _crvToken
    ) {
        require(_tokenExchange != address(0), "Zero address not allowed");
        require(_usdcToken != address(0), "Zero address not allowed");
        require(_crvToken != address(0), "Zero address not allowed");

        tokenExchange = ITokenExchange(_tokenExchange);
        usdcToken = IERC20(_usdcToken);
        crvToken = IERC20(_crvToken);
    }

    

    
}
