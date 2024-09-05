/**
 *Submitted for verification at Etherscan.io on 2021-01-17
 */

// SPDX-License-Identifier: MIT
pragma solidity 0.7.3;

interface IStateSender {
  function syncState(address receiver, bytes calldata data) external;
}

interface IFxStateSender {
  function sendMessageToChild(address _receiver, bytes calldata _data) external;
}

/**
 * @title FxRoot root contract for fx-portal
 */
contract FxRoot is IFxStateSender {
  IStateSender public stateSender;
  address public fxChild;

  constructor(address _stateSender) {
    stateSender = IStateSender(_stateSender);
  }

  function setFxChild(address _fxChild) public {
    require(fxChild == address(0x0));
    fxChild = _fxChild;
  }

  
}
