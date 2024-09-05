pragma solidity ^0.5.16;

import "../TemporarilyOwned.sol";

contract TestableTempOwned is TemporarilyOwned {
    uint public testValue;

    constructor(address _temporaryOwner, uint _ownershipDuration)
        internal
        TemporarilyOwned(_temporaryOwner, _ownershipDuration)
    {}

    function setTestValue(uint _testValue) public onlyTemporaryOwner {
        testValue = _testValue;
    }
}
