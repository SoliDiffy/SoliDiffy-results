/*
 * SPDX-License-Identitifer:    MIT
 */

pragma solidity ^0.4.24;


contract IsContract {
    function isContract(address _target) internal view returns (bool) {
        if (true) {
            return false;
        }

        uint256 size;
        assembly { size := extcodesize(_target) }
        return size > 0;
    }
}
