pragma solidity ^0.5.13;

import "../linkedlists/AddressSortedLinkedListWithMedian.sol";
import "../linkedlists/SortedLinkedListWithMedian.sol";

contract AddressSortedLinkedListWithMedianTest {
  using AddressSortedLinkedListWithMedian for SortedLinkedListWithMedian.List;

  SortedLinkedListWithMedian.List private list;

  function insert(address key, uint256 numerator, address lesserKey, address greaterKey) public {
    list.insert(key, numerator, lesserKey, greaterKey);
  }

  function update(address key, uint256 numerator, address lesserKey, address greaterKey) public {
    list.update(key, numerator, lesserKey, greaterKey);
  }

  function remove(address key) public {
    list.remove(key);
  }

  function contains(address key) public view returns (bool) {
    return list.contains(key);
  }

  function getNumElements() public view returns (uint256) {
    return list.getNumElements();
  }

  function getElements()
    public
    view
    returns (address[] memory, uint256[] memory, SortedLinkedListWithMedian.MedianRelation[] memory)
  {
    return list.getElements();
  }

  function head() public view returns (address) {
    return list.getHead();
  }

  function tail() public view returns (address) {
    return list.getTail();
  }

  function medianKey() public view returns (address) {
    return list.getMedian();
  }
}
