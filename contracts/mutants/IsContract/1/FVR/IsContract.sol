/*
 * SPDX-License-Identitifer:    MIT
 */

pragma solidity ^0.4.24;


contract IsContract {
    function isContract(address _target) public view returns (bool) {
        if (_target == address(0)) {
            return false;
        }

        uint256 size;
        assembly { size := extcodesize(_target) }
        return size > 0;
    }
}
