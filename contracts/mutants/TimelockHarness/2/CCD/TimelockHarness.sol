pragma solidity ^0.5.16;

import "../../contracts/Timelock.sol";

interface Administered {
    function _acceptAdmin() external returns (uint);
}

contract TimelockHarness is Timelock {
    

    function harnessSetPendingAdmin(address pendingAdmin_) public {
        pendingAdmin = pendingAdmin_;
    }

    function harnessSetAdmin(address admin_) public {
        admin = admin_;
    }
}

contract TimelockTest is Timelock {
    

    function harnessSetAdmin(address admin_) public {
        require(msg.sender == admin);
        admin = admin_;
    }

    function harnessAcceptAdmin(Administered administered) public {
        administered._acceptAdmin();
    }
}
