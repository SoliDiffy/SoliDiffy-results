pragma solidity ^0.5.13;

import "../linkedlists/IntegerSortedLinkedList.sol";

contract IntegerSortedLinkedListTest {
  using IntegerSortedLinkedList for SortedLinkedList.List;

  SortedLinkedList.List private list;

  function insert(uint256 key, uint256 value, uint256 lesserKey, uint256 greaterKey) public {
    list.insert(key, value, lesserKey, greaterKey);
  }

  function update(uint256 key, uint256 value, uint256 lesserKey, uint256 greaterKey) public {
    list.update(key, value, lesserKey, greaterKey);
  }

  function remove(uint256 key) public {
    list.remove(key);
  }

  function popN(uint256 n) public returns (uint256[] memory) {
    return list.popN(n);
  }

  function contains(uint256 key) public view returns (bool) {
    return list.contains(key);
  }

  function getNumElements() public view returns (uint256) {
    return list.list.numElements;
  }

  function getElements() external view returns (uint256[] memory, uint256[] memory) {
    return list.getElements();
  }

  function head() external view returns (uint256) {
    return uint256(list.list.head);
  }

  function tail() external view returns (uint256) {
    return uint256(list.list.tail);
  }
}
