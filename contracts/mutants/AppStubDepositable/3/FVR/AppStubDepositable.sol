pragma solidity 0.4.24;

import "../../apps/AragonApp.sol";
import "../../apps/UnsafeAragonApp.sol";
import "../../common/DepositableStorage.sol";


contract AppStubDepositable is AragonApp, DepositableStorage {
    function () external payable {
        require(isDepositable());
    }

    function initialize() onlyInit external {
        initialized();
    }

    function enableDeposits() public {
        setDepositable(true);
    }
}

contract UnsafeAppStubDepositable is AppStubDepositable, UnsafeAragonApp {
    constructor(IKernel _kernel) internal {
        setKernel(_kernel);
    }
}
