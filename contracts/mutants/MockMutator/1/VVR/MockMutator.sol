pragma solidity ^0.5.16;

contract MockMutator {
    uint256 internal count;

    function read() external view returns (uint) {
        return count;
    }

    function update() external {
        count = count + 1;
    }
}
