// SPDX-License-Identifier: MIT
pragma solidity 0.7.3;

// IStateReceiver represents interface to receive state
interface IStateReceiver {
  function onStateReceive(uint256 stateId, bytes calldata data) external;
}

// IFxMessageProcessor represents interface to process message
interface IFxMessageProcessor {
  function processMessageFromRoot(
    uint256 stateId,
    address rootMessageSender,
    bytes calldata data
  ) external;
}

/**
 * @title FxChild child contract for state receiver
 */
contract FxChild is IStateReceiver {
  address public fxRoot;

  event NewFxMessage(address rootMessageSender, address receiver, bytes data);

  function setFxRoot(address _fxRoot) public {
    require(fxRoot == address(0x0));
    fxRoot = _fxRoot;
  }

  
}
