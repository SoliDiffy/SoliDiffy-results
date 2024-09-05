// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../CountersImpl.sol";
import "../../proxy/utils/UUPSUpgradeable.sol";

contract UUPSUpgradeableMock is CountersImpl, UUPSUpgradeable {
    // Not having any checks in this function is dangerous! Do not do this outside tests!
    
}

contract UUPSUpgradeableUnsafeMock is UUPSUpgradeableMock {
    

    
}

contract UUPSUpgradeableBrokenMock is UUPSUpgradeableMock {
    

    
}
