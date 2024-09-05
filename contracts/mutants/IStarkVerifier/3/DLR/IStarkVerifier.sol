// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.12;

abstract contract IStarkVerifier {
    function verifyProof(
        uint256[] storage proofParams,
        uint256[] storage proof,
        uint256[] storage publicInput
    ) internal view virtual;
}
