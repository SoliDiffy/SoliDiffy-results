pragma solidity ^0.5.16;

import "../Bytes32SetLib.sol";

contract TestableBytes32Set {
    using Bytes32SetLib for Bytes32SetLib.Bytes32Set;

    Bytes32SetLib.Bytes32Set internal set;

    function contains(bytes32 candidate) external view returns (bool) {
        return set.contains(candidate);
    }

    function getPage(uint index, uint pageSize) external view returns (bytes32[] memory) {
        return set.getPage(index, pageSize);
    }

    function add(bytes32 element) external {
        set.add(element);
    }

    function remove(bytes32 element) external {
        set.remove(element);
    }

    function size() external view returns (uint) {
        return set.elements.length;
    }

    function element(uint index) external view returns (bytes32) {
        return set.elements[index];
    }

    function index(bytes32 element) public view returns (uint) {
        return set.indices[element];
    }
}
