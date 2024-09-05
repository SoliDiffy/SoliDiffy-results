pragma solidity >=0.6.0 <0.7.0;

import "../utils/MappedSinglyLinkedList.sol";

contract MappedSinglyLinkedListExposed {
  using MappedSinglyLinkedList for MappedSinglyLinkedList.Mapping;

  MappedSinglyLinkedList.Mapping list;

  function initialize() public {
    list.initialize();
  }

  function addressArray() public view returns (address[] memory) {
    return list.addressArray();
  }

  function addAddresses(address[] calldata addresses) public {
    list.addAddresses(addresses);
  }

  function addAddress(address newAddress) public {
    list.addAddress(newAddress);
  }

  function removeAddress(address prevAddress, address addr) external {
    list.removeAddress(prevAddress, addr);
  }

  function contains(address addr) external view returns (bool) {
    return list.contains(addr);
  }

  function clearAll() external {
    list.clearAll();
  }

}