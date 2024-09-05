pragma solidity 0.5.8;

import "../../../proxy/OwnedUpgradeabilityProxy.sol";
import "./ManualApprovalTransferManagerStorage.sol";
import "../../../Pausable.sol";
import "../../../storage/modules/ModuleStorage.sol";

/**
 @title ManualApprovalTransferManager module Proxy
 */
contract ManualApprovalTransferManagerProxy is ManualApprovalTransferManagerStorage, ModuleStorage, Pausable, OwnedUpgradeabilityProxy {

    /**
    * @notice Constructor
    * @param _securityToken Address of the security token
    * @param _polyAddress Address of the polytoken
    * @param _implementation representing the address of the new implementation to be set
    */
    

}
