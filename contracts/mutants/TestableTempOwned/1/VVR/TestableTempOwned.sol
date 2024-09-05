pragma solidity ^0.5.16;

import "../TemporarilyOwned.sol";

contract TestableTempOwned is TemporarilyOwned {
    uint internal testValue;

    constructor(address _temporaryOwner, uint _ownershipDuration)
        public
        TemporarilyOwned(_temporaryOwner, _ownershipDuration)
    {}

    function setTestValue(uint _testValue) external onlyTemporaryOwner {
        testValue = _testValue;
    }
}
