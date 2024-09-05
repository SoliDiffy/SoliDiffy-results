pragma solidity ^0.4.10;

/**@dev Simple interface to Owned base class */
contract IOwned {
    function owner() external constant returns (address) {}
    function transferOwnership(address _newOwner) public;
}