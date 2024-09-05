// SPDX-License-Identifier: MIT

pragma solidity ^0.7.6;

import "./IUmbraHookReceiver.sol";

/// @dev Mock implementation of UmbraHookable used for testing
contract MockHook is IUmbraHookReceiver {
  struct CallHookData {
    uint256 amount;
    address stealthAddr;
    address acceptor;
    address tokenAddr;
    address sponsor;
    uint256 sponsorFee;
    bytes data;
  }

  CallHookData public lastCallData;

  
}
