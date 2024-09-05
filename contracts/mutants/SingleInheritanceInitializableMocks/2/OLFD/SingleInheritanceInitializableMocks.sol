// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "../proxy/Initializable.sol";

/**
 * @title MigratableMockV1
 * @dev This contract is a mock to test initializable functionality through migrations
 */
contract MigratableMockV1 is Initializable {
  uint256 public x;

  function initialize(uint256 value) public payable initializer {
    x = value;
  }
}

/**
 * @title MigratableMockV2
 * @dev This contract is a mock to test migratable functionality with params
 */
contract MigratableMockV2 is MigratableMockV1 {
  bool internal _migratedV2;
  uint256 public y;

  
}

/**
 * @title MigratableMockV3
 * @dev This contract is a mock to test migratable functionality without params
 */
contract MigratableMockV3 is MigratableMockV2 {
  bool internal _migratedV3;

  
}
