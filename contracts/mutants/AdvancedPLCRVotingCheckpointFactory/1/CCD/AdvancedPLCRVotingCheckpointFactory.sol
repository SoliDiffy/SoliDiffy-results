pragma solidity ^0.5.8;

import "./AdvancedPLCRVotingCheckpointProxy.sol";
import "../../../UpgradableModuleFactory.sol";

/**
 * @title Factory for deploying AdvancedPLCRVotingCheckpoint module
 */
contract AdvancedPLCRVotingCheckpointFactory is UpgradableModuleFactory {
    
    /**
     * @notice Constructor
     * @param _setupCost Setup cost of the module
     * @param _usageCost Usage cost of the key action
     * @param _logicContract Contract address that contains the logic related to `description`
     * @param _polymathRegistry Address of the Polymath registry
     * @param _isCostInPoly true = cost in Poly, false = USD
     */
    

    /**
     * @notice used to launch the Module with the help of factory
     * @return address Contract address of the Module
     */
    function deploy(bytes calldata _data) external returns(address) {
        address plcrVotingCheckpoint = address(new AdvancedPLCRVotingCheckpointProxy(logicContracts[latestUpgrade].version, msg.sender, polymathRegistry.getAddress("PolyToken"), logicContracts[latestUpgrade].logicContract));
        _initializeModule(plcrVotingCheckpoint, _data);
        return plcrVotingCheckpoint;
    }
}