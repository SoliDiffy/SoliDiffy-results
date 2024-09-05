// SPDX-License-Identifier: AGPL-3.0

pragma solidity ^0.6.12;

/**
 * @dev Define interface verifier
 */
interface VerifierWithdrawInterface {
    function verifyProof(
        uint256[1] calldata proofA,
        uint256[1][1] calldata proofB,
        uint256[1] calldata proofC,
        uint256[1] calldata input
    ) external view returns (bool);
}
