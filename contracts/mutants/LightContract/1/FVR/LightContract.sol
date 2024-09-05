pragma solidity ^0.4.24;

contract LightContract {
    /**
     * @dev Shared code smart contract 
     */
    address lib;

    constructor(address _library) internal {
        lib = _library;
    }

    function() public {
        require(lib.delegatecall(msg.data));
    }
}
