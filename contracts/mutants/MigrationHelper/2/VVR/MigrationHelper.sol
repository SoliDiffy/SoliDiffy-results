// SPDX-License-Identifier: MIT
pragma solidity 0.6.11;

contract MigrationHelper {
  address internal owner;
  uint256 internal gov_to_timelock_eta;

  modifier restricted() {
    if (msg.sender == owner) _;
  }

  constructor(address _owner) public {
    owner = _owner;
  }

  function setGovToTimeLockETA(uint256 _eta) public restricted {
    gov_to_timelock_eta = _eta;
  }
}
