pragma solidity 0.5.8;

import "./KYCTransferManager.sol";
import "./../../ModuleFactory.sol";


contract KYCTransferManagerFactory is ModuleFactory {

    /**
     * @notice Constructor
     * @param _setupCost Setup cost of module
     * @param _usageCost Usage cost of the module
     * @param _polymathRegistry Address of the Polymath registry
     * @param _isCostInPoly true = cost in Poly, false = USD
     */
    


    /**
     * @notice Used to launch the Module with the help of factory
     * @return address Contract address of the Module
     */
    function deploy(bytes calldata _data) external returns(address) {
        address kycTransferManager = address(new KYCTransferManager(msg.sender, polymathRegistry.getAddress("PolyToken")));
        _initializeModule(kycTransferManager, _data);
        return kycTransferManager;
    }

}
