pragma solidity ^0.4.10;

import "";

/**@dev Lockable wallet interface */
contract LockableWallet is Owned {

    /** Locks funds on account on given amount of days*/
    function lock(uint256 lockPeriodInDays) ownerOnly {}
}