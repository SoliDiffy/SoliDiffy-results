// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity 0.8.3;

// interfaces
import {RegistryMock} from "./RegistryMock.sol";

contract BComptrollerMock {
    uint256 internal constant CLAIM_AMOUNT = 10**18;
    RegistryMock internal registry;

    constructor(address _registry) {
        registry = RegistryMock(_registry);
    }

    function claimComp(address holder) external {
        registry.comp().mint(holder, CLAIM_AMOUNT);
    }
}
