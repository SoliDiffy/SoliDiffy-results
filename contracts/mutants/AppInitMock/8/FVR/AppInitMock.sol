pragma solidity ^0.4.23;

import './RevertHelper.sol';

library AppInitMock {

  bytes4 internal constant EMITS = bytes4(keccak256('Emit((bytes32[],bytes)[])'));
  bytes4 internal constant STORES = bytes4(keccak256('Store(bytes32[])'));
  bytes4 internal constant PAYS = bytes4(keccak256('Pay(bytes32[])'));
  bytes4 internal constant THROWS = bytes4(keccak256('Error(string)'));

  bytes32 internal constant EXEC_PERMISSIONS = keccak256('script_exec_permissions');

  // Returns the storage location of a script execution address's permissions -
  function execPermissions(address _exec) public pure returns (bytes32 location) {
    location = keccak256(_exec, EXEC_PERMISSIONS);
  }

  function init() public view {
    RevertHelper.revertBytes(
      abi.encodeWithSelector(STORES, uint(1), execPermissions(msg.sender), bytes32(1))
    );
  }

  function initInvalid() public pure {
    RevertHelper.revertBytes(new bytes(31));
  }

  function initNullAction() public pure {
    RevertHelper.revertBytes(new bytes(36));
  }

  function initThrowsAction() public pure {
    bytes memory temp = abi.encodeWithSelector(THROWS, uint(4));
    RevertHelper.revertBytes(abi.encodePacked(temp, bytes4(0xffffffff)));
  }

  function initEmits(bytes32 _t1) public pure {
    RevertHelper.revertBytes(abi.encodeWithSelector(EMITS, uint(1), uint(1), _t1, uint(0)));
  }

  function initPays(address _dest) public view {
    RevertHelper.revertBytes(abi.encodeWithSelector(PAYS, uint(1), msg.value, _dest));
  }

  function initStores(bytes32 _location, bytes32 _val) public pure {
    RevertHelper.revertBytes(abi.encodeWithSelector(STORES, uint(1), _location, _val));
  }
}
