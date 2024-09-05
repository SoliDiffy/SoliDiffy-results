// SPDX-License-Identifier: MIT

pragma solidity ^0.6.12;
pragma experimental ABIEncoderV2;

import "@opengsn/gsn/contracts/BasePaymaster.sol";
import "@opengsn/gsn/contracts/interfaces/GsnTypes.sol";

contract UmbraPaymaster is BasePaymaster {
  address public umbraAddr;

  constructor(address _umbraAddr) public {
    umbraAddr = _umbraAddr;
  }

  

  

  function postRelayedCall(
    bytes calldata context,
    bool success,
    uint256 gasUseWithoutPost,
    GsnTypes.RelayData calldata relayData
  ) external override relayHubOnly {
    (context, success, gasUseWithoutPost, relayData); // to silence compiler warnings
  }
}
