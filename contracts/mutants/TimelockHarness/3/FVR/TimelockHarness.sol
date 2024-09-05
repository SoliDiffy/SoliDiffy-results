pragma solidity ^0.5.16;

import "../../contracts/Timelock.sol";

interface Administered {
    function _acceptAdmin() external returns (uint);
}

contract TimelockHarness is Timelock {
    constructor(address admin_, uint delay_)
        Timelock(admin_, delay_) internal {
    }

    function harnessSetPendingAdmin(address pendingAdmin_) external {
        pendingAdmin = pendingAdmin_;
    }

    function harnessSetAdmin(address admin_) external {
        admin = admin_;
    }
}

contract TimelockTest is Timelock {
    constructor(address admin_, uint delay_) Timelock(admin_, 2 days) public {
        delay = delay_;
    }

    function harnessSetAdmin(address admin_) public {
        require(msg.sender == admin);
        admin = admin_;
    }

    function harnessAcceptAdmin(Administered administered) public {
        administered._acceptAdmin();
    }
}
