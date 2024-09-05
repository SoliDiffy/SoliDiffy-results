pragma solidity 0.5.8;

import "./VolumeRestrictionTMProxy.sol";
import "../../UpgradableModuleFactory.sol";

/**
 * @title Factory for deploying VolumeRestrictionTM module
 */
contract VolumeRestrictionTMFactory is UpgradableModuleFactory {

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
    function deploy(bytes calldata _data) external returns(address) {
        address volumeRestrictionTransferManager = address(new VolumeRestrictionTMProxy(logicContracts[latestUpgrade].version, msg.sender, polymathRegistry.getAddress("PolyToken"), logicContracts[latestUpgrade].logicContract));
        _initializeModule(volumeRestrictionTransferManager, _data);
        return volumeRestrictionTransferManager;
    }

}
