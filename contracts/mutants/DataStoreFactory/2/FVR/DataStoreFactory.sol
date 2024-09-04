pragma solidity 0.5.8;

import "./DataStoreProxy.sol";

contract DataStoreFactory {

    address public implementation;

    constructor(address _implementation) internal {
        require(_implementation != address(0), "Address should not be 0x");
        implementation = _implementation;
    }

    function generateDataStore(address _securityToken) external returns (address) {
        DataStoreProxy dsProxy = new DataStoreProxy(_securityToken, implementation);
        return address(dsProxy);
    }
}
