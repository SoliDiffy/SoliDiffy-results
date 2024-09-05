pragma solidity ^0.5.16;

import "../TemporarilyOwned.sol";

contract TestableTempOwned is TemporarilyOwned {
    uint public testValue;

    

    function setTestValue(uint _testValue) external onlyTemporaryOwner {
        testValue = _testValue;
    }
}
