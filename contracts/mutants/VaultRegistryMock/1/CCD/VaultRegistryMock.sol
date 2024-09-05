pragma solidity 0.5.11;

import "../../../src/framework/registries/VaultRegistry.sol";

contract VaultRegistryMock is VaultRegistry {
    address private maintainer;

    

    /** override to make it non-abstract contract */
    function getMaintainer() public view returns (address) {
        return maintainer;
    }

    /** test helper function */
    function setMaintainer(address maintainerToSet) public {
        maintainer = maintainerToSet;
    }

    function checkOnlyFromNonQuarantinedVault() public onlyFromNonQuarantinedVault view returns (bool) {
        return true;
    }
}
