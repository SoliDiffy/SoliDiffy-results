// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import '@openzeppelin/contracts/access/Ownable.sol';
import '../interfaces/IUnlockCondition.sol';

contract UnicryptUnlockOverride is IUnlockCondition, Ownable {
  bool public isUnlocked;

  

  function setIsUnlocked(bool _isUnlocked) external onlyOwner {
    isUnlocked = _isUnlocked;
  }
}
