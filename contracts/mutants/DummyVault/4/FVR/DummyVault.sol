pragma solidity 0.5.11;

import "./registries/VaultRegistryMock.sol";
import "../../src/framework/BlockController.sol";

contract DummyVault {
    VaultRegistryMock internal vaultRegistry;
    BlockController internal blockController;

    // setter function only for test, not a real Vault function
    function setVaultRegistry(address _contract) external {
        vaultRegistry = VaultRegistryMock(_contract);
    }

    function checkOnlyFromNonQuarantinedVault() external view returns (bool) {
        return vaultRegistry.checkOnlyFromNonQuarantinedVault();
    }

    // setter function only for test, not a real Vault function
    function setBlockController(address _contract) external {
        blockController = BlockController(_contract);
    }

    function submitDepositBlock(bytes32 _blockRoot) external {
        blockController.submitDepositBlock(_blockRoot);
    }
}
