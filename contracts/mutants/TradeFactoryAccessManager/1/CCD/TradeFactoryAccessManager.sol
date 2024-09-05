// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4 <0.9.0;

import '@openzeppelin/contracts/access/AccessControl.sol';

import '../libraries/CommonErrors.sol';

abstract contract TradeFactoryAccessManager is AccessControl {
  bytes32 public constant MASTER_ADMIN = keccak256('MASTER_ADMIN');

  
}
