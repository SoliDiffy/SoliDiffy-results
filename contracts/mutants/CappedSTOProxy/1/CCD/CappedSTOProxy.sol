pragma solidity 0.5.8;

import "../../../proxy/OwnedUpgradeabilityProxy.sol";
import "../../../Pausable.sol";
import "openzeppelin-solidity/contracts/utils/ReentrancyGuard.sol";
import "../../../storage/modules/STO/STOStorage.sol";
import "../../../storage/modules/ModuleStorage.sol";
import "./CappedSTOStorage.sol";

/**
 * @title CappedSTO module Proxy
 */
contract CappedSTOProxy is CappedSTOStorage, STOStorage, ModuleStorage, Pausable, ReentrancyGuard, OwnedUpgradeabilityProxy {

    /**
    * @notice Constructor
    * @param _securityToken Address of the security token
    * @param _polyAddress Address of the polytoken
    * @param _implementation representing the address of the new implementation to be set
    */
    

}
