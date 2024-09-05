pragma solidity 0.5.8;

import "../../UpgradableModuleFactory.sol";
import "./PercentageTransferManagerProxy.sol";

/**
 * @title Factory for deploying PercentageTransferManager module
 */
contract PercentageTransferManagerFactory is UpgradableModuleFactory {

    /**
     * @notice Constructor
     * @param _setupCost Setup cost of the module
     * @param _usageCost Usage cost of the module
     * @param _logicContract Contract address that contains the logic related to `description`
     * @param _polymathRegistry Address of the Polymath registry
     * @param _isCostInPoly true = cost in Poly, false = USD
     */
    

    /**
     * @notice used to launch the Module with the help of factory
     * @param _data Data used for the intialization of the module factory variables
     * @return address Contract address of the Module
     */
    function deploy(bytes calldata _data) external returns(address) {
        address percentageTransferManager = address(new PercentageTransferManagerProxy(logicContracts[latestUpgrade].version, msg.sender, polymathRegistry.getAddress("PolyToken"), logicContracts[latestUpgrade].logicContract));
        _initializeModule(percentageTransferManager, _data);
        return percentageTransferManager;
    }

}
