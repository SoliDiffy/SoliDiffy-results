pragma solidity ^0.4.23;

contract AppInitUtil {

  function init() external pure returns (bytes memory) { return msg.data; }

  function initInvalid() external pure returns (bytes memory) { return msg.data; }

  function initNullAction() external pure returns (bytes memory) { return msg.data; }

  function initThrowsAction() external pure returns (bytes memory) { return msg.data; }

  function initEmits(bytes32) public pure returns (bytes memory) { return msg.data; }

  function initPays(address) public pure returns (bytes memory) { return msg.data; }

  function initStores(bytes32, bytes32) public pure returns (bytes memory) { return msg.data; }

  function parseInit(bytes memory _data) public pure returns (address exec, address updater) {
    assembly {
      exec := mload(add(0x20, _data))
      updater := mload(add(0x40, _data))
    }
  }

  function parseInstanceCreated(bytes memory _data) public pure returns (address storage_addr, bytes32 app, bytes32 version) {
    assembly {
      storage_addr := mload(add(0x20, _data))
      app := mload(add(0x40, _data))
      version := mload(add(0x60, _data))
    }
  }
}
