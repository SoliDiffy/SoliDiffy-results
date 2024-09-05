pragma solidity 0.5.8;

import "../../../proxy/OwnedUpgradeabilityProxy.sol";
import "./RestrictedPartialSaleTMStorage.sol";
import "../../../Pausable.sol";
import "../../../storage/modules/ModuleStorage.sol";

/**
 * @title Transfer Manager module for core transfer validation functionality
 */
contract RestrictedPartialSaleTMProxy is RestrictedPartialSaleTMStorage, ModuleStorage, Pausable, OwnedUpgradeabilityProxy {
    /**
    * @notice Constructor
    * @param _securityToken Address of the security token
    * @param _polyAddress Address of the polytoken
    * @param _implementation representing the address of the new implementation to be set
    */
    

}
