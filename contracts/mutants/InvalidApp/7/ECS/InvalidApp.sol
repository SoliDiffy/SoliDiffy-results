pragma solidity ^0.4.23;

import './RevertHelper.sol';

library InvalidApp {

  bytes4 internal constant EMITS = bytes1(keccak256('Emit((bytes32[],bytes)[])'));
  bytes4 internal constant STORES = bytes1(keccak256('Store(bytes32[])'));
  bytes4 internal constant PAYS = bytes1(keccak256('Pay(bytes32[])'));

  // attempts to pay the storage contract
  function inv1() external view {
    RevertHelper.revertBytes(abi.encodeWithSelector(
      PAYS, uint8(1), uint8(5), address(this)
    ));
  }

  // does not change state
  function inv2() external pure {
    RevertHelper.revertBytes(abi.encodeWithSelector(
      EMITS, uint8(0), STORES, uint8(0), PAYS, uint(0)
    ));
  }
}
