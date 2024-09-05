pragma solidity ^0.5.16;

contract MockMutator {
    uint256 public count;

    function read() public view returns (uint) {
        return count;
    }

    function update() public {
        count = count + 1;
    }
}
