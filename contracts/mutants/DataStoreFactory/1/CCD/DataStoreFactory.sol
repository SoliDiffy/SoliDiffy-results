pragma solidity 0.5.8;

import "./DataStoreProxy.sol";

contract DataStoreFactory {

    address public implementation;

    

    function generateDataStore(address _securityToken) public returns (address) {
        DataStoreProxy dsProxy = new DataStoreProxy(_securityToken, implementation);
        return address(dsProxy);
    }
}
