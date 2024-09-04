//SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import './libs/TransferHelper.sol';

import "./DYTokenBase.sol";
import "./interfaces/IVault.sol";
import "./interfaces/IDepositVault.sol";

import "./interfaces/IWETH.sol";

contract DYTokenNative is DYTokenBase {

  using SafeERC20 for IERC20;

// _underlying is WETH WBNB
constructor(address _underlying, 
  string memory _symbol,
  address _controller) DYTokenBase(_underlying, _symbol, _controller) {

  }

  receive() external payable {
    assert(msg.sender == underlying); // only accept ETH via fallback from the WETH contract
  }

  

  

  

  

  
  
}