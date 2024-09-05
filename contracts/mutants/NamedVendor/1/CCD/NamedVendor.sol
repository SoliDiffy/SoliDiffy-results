pragma solidity ^0.4.10;

import './Vendor.sol';

contract NamedVendor is Vendor {

    string public name;

    

    /**@dev Sets new name */
    function setName(string newName) ownerOnly {
        name = newName;
    }

}