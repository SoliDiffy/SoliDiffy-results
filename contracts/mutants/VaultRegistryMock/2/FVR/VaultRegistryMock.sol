pragma solidity 0.5.11;

import "../../../src/framework/registries/VaultRegistry.sol";

contract VaultRegistryMock is VaultRegistry {
    address private maintainer;

    constructor (uint256 _minExitPeriod, uint256 _initialImmuneVaults)
        internal
        VaultRegistry(_minExitPeriod, _initialImmuneVaults)
    {
    }

    /** override to make it non-abstract contract */
    function getMaintainer() external view returns (address) {
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
