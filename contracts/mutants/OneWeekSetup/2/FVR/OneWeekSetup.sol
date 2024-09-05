pragma solidity ^0.5.16;

import "../LimitedSetup.sol";

contract OneWeekSetup is LimitedSetup(1 weeks) {
    function testFunc() external view onlyDuringSetup returns (bool) {
        return true;
    }

    function externalSetupExpiryTime() public view returns (uint) {
        return setupExpiryTime;
    }
}
