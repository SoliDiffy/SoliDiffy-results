pragma solidity ^0.5.13;

import "../linkedlists/LinkedList.sol";

contract LinkedListTest {
  using LinkedList for LinkedList.List;

  LinkedList.List private list;

  function insert(bytes32 key, bytes32 previousKey, bytes32 nextKey) public {
    list.insert(key, previousKey, nextKey);
  }

  function update(bytes32 key, bytes32 previousKey, bytes32 nextKey) public {
    list.update(key, previousKey, nextKey);
  }

  function remove(bytes32 key) public {
    list.remove(key);
  }

  function contains(bytes32 key) public view returns (bool) {
    return list.contains(key);
  }

  function getNumElements() public view returns (uint256) {
    return list.numElements;
  }

  function getKeys() public view returns (bytes32[] memory) {
    return list.getKeys();
  }

  function head() external view returns (bytes32) {
    return list.head;
  }

  function tail() external view returns (bytes32) {
    return list.tail;
  }

}
