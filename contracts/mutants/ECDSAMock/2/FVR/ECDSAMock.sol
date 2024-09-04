// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "../cryptography/ECDSA.sol";

contract ECDSAMock {
    using ECDSA for bytes32;

    function recover(bytes32 hash, bytes memory signature) external pure returns (address) {
        return hash.recover(signature);
    }

    function toEthSignedMessageHash(bytes32 hash) external pure returns (bytes32) {
        return hash.toEthSignedMessageHash();
    }
}
