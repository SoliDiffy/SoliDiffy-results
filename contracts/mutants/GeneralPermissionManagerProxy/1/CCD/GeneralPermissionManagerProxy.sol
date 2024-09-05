pragma solidity 0.5.8;

import "../../proxy/OwnedUpgradeabilityProxy.sol";
import "../../Pausable.sol";
import "openzeppelin-solidity/contracts/utils/ReentrancyGuard.sol";
import "../../storage/modules/ModuleStorage.sol";
import "./GeneralPermissionManagerStorage.sol";

/**
 * @title GeneralPermissionManager module Proxy
 */
contract GeneralPermissionManagerProxy is GeneralPermissionManagerStorage, ModuleStorage, Pausable, ReentrancyGuard, OwnedUpgradeabilityProxy {

    /**
    * @notice Constructor
    * @param _securityToken Address of the security token
    * @param _polyAddress Address of the polytoken
    * @param _implementation representing the address of the new implementation to be set
    */
    

}
