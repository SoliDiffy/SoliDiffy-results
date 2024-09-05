// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4 <0.9.0;

import './UtilsReady.sol';
import '../utils/Machinery.sol';

abstract contract MachineryReady is UtilsReady, Machinery {
  constructor(address _mechanicsRegistry) Machinery(_mechanicsRegistry) UtilsReady() {}

  // Machinery: restricted-access
  

  // Machinery: modifiers
  modifier onlyGovernorOrMechanic() {
    require(isGovernor(msg.sender) || isMechanic(msg.sender), 'Machinery::onlyGovernorOrMechanic:invalid-msg-sender');
    _;
  }
}
