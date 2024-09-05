// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4 <0.9.0;

import '../utils/Governable.sol';
import '../utils/CollectableDust.sol';
import '../utils/Pausable.sol';

abstract contract UtilsReady is Governable, CollectableDust, Pausable {
  constructor() Governable(msg.sender) {}

  // Governable: restricted-access
  

  

  // Collectable Dust: restricted-access
  

  // Pausable: restricted-access
  function pause(bool _paused) external override onlyGovernor {
    _pause(_paused);
  }
}
