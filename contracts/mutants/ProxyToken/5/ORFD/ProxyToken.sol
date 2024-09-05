// SPDX-License-Identifier: MIT
/**
  ∩~~~~∩ 
  ξ ･×･ ξ 
  ξ　~　ξ 
  ξ　　 ξ 
  ξ　　 “~～~～〇 
  ξ　　　　　　 ξ 
  ξ ξ ξ~～~ξ ξ ξ 
　 ξ_ξξ_ξ　ξ_ξξ_ξ
Alpaca Fin Corporation
*/

pragma solidity 0.8.10;

import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/utils/math/SafeMathUpgradeable.sol";

import "./interfaces/IProxyToken.sol";

contract ProxyToken is IProxyToken, ERC20Upgradeable, OwnableUpgradeable {
  using SafeMathUpgradeable for uint256;

  /// @dev Events
  event LogSetOkHolder(address _holder, bool _isOk);

  /// @notice just reserve for future use
  address public timelock;

  mapping(address => bool) public okHolders;

  modifier onlyTimelock() {
    require(timelock == msg.sender, "proxyToken::onlyTimelock:: msg.sender not timelock");
    _;
  }

  function initialize(
    string calldata _name,
    string calldata _symbol,
    address _timelock
  ) external initializer {
    OwnableUpgradeable.__Ownable_init();
    ERC20Upgradeable.__ERC20_init(_name, _symbol);
    timelock = _timelock;
  }

  

  

  

  

  
}
