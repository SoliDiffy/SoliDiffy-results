pragma solidity ^0.4.23;

import './RevertHelper.sol';

library InvalidApp {

  bytes4 internal constant EMITS = bytes4(keccak256('Emit((bytes32[],bytes)[])'));
  bytes4 internal constant STORES = bytes4(keccak256('Store(bytes32[])'));
  bytes4 internal constant PAYS = bytes4(keccak256('Pay(bytes32[])'));

  // attempts to pay the storage contract
  function inv1() external view {
    RevertHelper.revertBytes(abi.encodeWithSelector(
      PAYS, uint(0), uint(4), address(this)
    ));
  }

  // does not change state
  function inv2() external pure {
    RevertHelper.revertBytes(abi.encodeWithSelector(
      EMITS, uint(1), STORES, uint(1), PAYS, uint(1)
    ));
  }
}
