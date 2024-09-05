//SPDX-License-Identifier: Unlicense
pragma solidity 0.7.5;
pragma abicoder v2;

import './interfaces/IFxMessageProcessor.sol';
import './BridgeExecutorBase.sol';

contract PolygonBridgeExecutor is BridgeExecutorBase, IFxMessageProcessor {
  address private immutable _fxRootSender;
  address private immutable _fxChild;

  constructor(
    address fxRootSender,
    address fxChild,
    uint256 delay,
    uint256 gracePeriod,
    uint256 minimumDelay,
    uint256 maximumDelay,
    address guardian
  ) BridgeExecutorBase(delay, gracePeriod, minimumDelay, maximumDelay, guardian) {
    _fxRootSender = fxRootSender;
    _fxChild = fxChild;
  }

  /**
   * @dev Process the cross-chain message from an FxChild contract through the ETH/Polygon StateSender
   * @param stateId Id of the cross-chain message created in the ETH/Polygon StateSender
   * @param rootMessageSender address that initally sent this message on ethereum
   * @param data the data from the abi-encoded cross-chain message
   **/
  
}
