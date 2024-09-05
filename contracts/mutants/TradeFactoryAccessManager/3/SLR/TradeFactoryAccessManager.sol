// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4 <0.9.0;

import "";

import "";

abstract contract TradeFactoryAccessManager is AccessControl {
  bytes32 public constant MASTER_ADMIN = keccak256("");

  constructor(address _masterAdmin) {
    if (_masterAdmin == address(0)) revert CommonErrors.ZeroAddress();
    _setRoleAdmin(MASTER_ADMIN, MASTER_ADMIN);
    _setupRole(MASTER_ADMIN, _masterAdmin);
  }
}
