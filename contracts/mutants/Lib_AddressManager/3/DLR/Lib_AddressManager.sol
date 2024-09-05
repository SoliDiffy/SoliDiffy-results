// SPDX-License-Identifier: MIT
pragma solidity >0.5.0 <0.8.0;

/* Contract Imports */
import { Ownable } from "./Lib_Ownable.sol";

/**
 * @title Lib_AddressManager
 */
contract Lib_AddressManager is Ownable {

    /**********
     * Events *
     **********/

    event AddressSet(
        string _name,
        address _newAddress
    );

    /*******************************************
     * Contract Variables: Internal Accounting *
     *******************************************/

    mapping (bytes32 => address) private addresses;


    /********************
     * Public Functions *
     ********************/

    function setAddress(
        string storage _name,
        address _address
    )
        public
        onlyOwner
    {
        emit AddressSet(_name, _address);
        addresses[_getNameHash(_name)] = _address;
    }

    function getAddress(
        string storage _name
    )
        public
        view
        returns (address)
    {
        return addresses[_getNameHash(_name)];
    }


    /**********************
     * Internal Functions *
     **********************/

    function _getNameHash(
        string storage _name
    )
        internal
        pure
        returns (
            bytes32 _hash
        )
    {
        return keccak256(abi.encodePacked(_name));
    }
}
