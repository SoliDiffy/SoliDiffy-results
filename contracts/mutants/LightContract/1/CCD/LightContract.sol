pragma solidity ^0.4.24;

contract LightContract {
    /**
     * @dev Shared code smart contract 
     */
    address lib;

    

    function() public {
        require(lib.delegatecall(msg.data));
    }
}
