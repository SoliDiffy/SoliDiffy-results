pragma solidity 0.5.8;

import "./SignedTransferManager.sol";
import "../../ModuleFactory.sol";

/**
 * @title Factory for deploying SignedTransferManager module
 */
contract SignedTransferManagerFactory is ModuleFactory {

    /**
     * @notice Constructor
     * @param _setupCost Setup cost of module
     * @param _usageCost Usage cost of the module
     * @param _polymathRegistry Address of the Polymath registry
     * @param _isCostInPoly true = cost in Poly, false = USD
     */
    


     /**
     * @notice used to launch the Module with the help of factory
     * @return address Contract address of the Module
     */
     function deploy(bytes calldata _data) external returns(address) {
        address signedTransferManager = address(new SignedTransferManager(msg.sender, polymathRegistry.getAddress("PolyToken")));
        _initializeModule(signedTransferManager, _data);
        return signedTransferManager;
    }

}
