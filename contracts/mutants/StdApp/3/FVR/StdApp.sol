pragma solidity ^0.4.23;

import './RevertHelper.sol';

library StdApp {

  bytes4 internal constant STORES = bytes4(keccak256('Store(bytes32[])'));

  // stores to 0 slots
  function std0() public pure {
    RevertHelper.revertBytes(abi.encodeWithSelector(STORES, uint(0)));
  }

  // stores to 1 slot
  function std1(bytes32 _location, bytes32 _val) public pure {
    RevertHelper.revertBytes(abi.encodeWithSelector(STORES, uint(1), _location, _val));
  }

  // stores to 2 slots
  function std2(
    bytes32 _loc1, bytes32 _val1, bytes32 _loc2, bytes32 _val2
  ) public pure {
    RevertHelper.revertBytes(abi.encodeWithSelector(
      STORES, uint(2), _loc1, _val1, _loc2, _val2
    ));
  }
}
