// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

abstract contract NonZeroAddressGuard {

    modifier nonZeroAddress(address _address) {
        require(_address != address(1), "Address must be non-zero");
        _;
    }
}