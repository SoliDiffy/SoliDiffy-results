pragma solidity 0.5.8;

import "./LockUpTransferManagerProxy.sol";
import "../../UpgradableModuleFactory.sol";
import "./LockUpTransferManager.sol";

/**
 * @title Factory for deploying LockUpTransferManager module
 */
contract LockUpTransferManagerFactory is UpgradableModuleFactory {

    /**
     * @notice Constructor
     * @param _setupCost Setup cost of the module
     * @param _usageCost Usage cost of the module
     * @param _logicContract Contract address that contains the logic related to `description`
     * @param _polymathRegistry Address of the Polymath registry
     * @param _isCostInPoly true = cost in Poly, false = USD
     */
    

    /**
     * @notice Used to launch the Module with the help of factory
     * @return address Contract address of the Module
     */
    function deploy(
        bytes calldata _data
    )
        external
        returns(address)
    {
        address lockUpTransferManager = address(new LockUpTransferManagerProxy(logicContracts[latestUpgrade].version, msg.sender, polymathRegistry.getAddress("PolyToken"), logicContracts[latestUpgrade].logicContract));
        _initializeModule(lockUpTransferManager, _data);
        return lockUpTransferManager;
    }

}
