pragma solidity 0.5.8;

import "../proxy/Proxy.sol";
import "./DataStoreStorage.sol";

/**
 * @title DataStoreProxy Proxy
 */
contract DataStoreProxy is DataStoreStorage, Proxy {

    /**
    * @notice Constructor
    * @param _securityToken Address of the security token
    * @param _implementation representing the address of the new implementation to be set
    */
    

    /**
    * @notice Internal function to provide the address of the implementation contract
    */
    function _implementation() internal view returns(address) {
        return __implementation;
    }

}
