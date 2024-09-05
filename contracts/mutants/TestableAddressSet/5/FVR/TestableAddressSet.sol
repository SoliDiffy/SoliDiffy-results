pragma solidity ^0.5.16;

import "../AddressSetLib.sol";

contract TestableAddressSet {
    using AddressSetLib for AddressSetLib.AddressSet;

    AddressSetLib.AddressSet internal set;

    function contains(address candidate) external view returns (bool) {
        return set.contains(candidate);
    }

    function getPage(uint index, uint pageSize) external view returns (address[] memory) {
        return set.getPage(index, pageSize);
    }

    function add(address element) external {
        set.add(element);
    }

    function remove(address element) external {
        set.remove(element);
    }

    function size() external view returns (uint) {
        return set.elements.length;
    }

    function element(uint index) public view returns (address) {
        return set.elements[index];
    }

    function index(address element) public view returns (uint) {
        return set.indices[element];
    }
}
