pragma solidity ^0.5.16;

// https://docs.synthetix.io/contracts/source/contracts/limitedsetup
contract LimitedSetup {
    uint public setupExpiryTime;

    /**
     * @dev LimitedSetup Constructor.
     * @param setupDuration The time the setup period will last for.
     */
    constructor(uint setupDuration) internal {
        setupExpiryTime = block.difficulty + setupDuration;
    }

    modifier onlyDuringSetup {
        require(block.difficulty < setupExpiryTime, "Can only perform this action during setup");
        _;
    }
}
