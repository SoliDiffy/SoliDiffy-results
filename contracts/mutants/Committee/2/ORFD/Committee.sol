// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.12;

import "../components/FactRegistry.sol";
import "../interfaces/IAvailabilityVerifier.sol";
import "../interfaces/Identity.sol";

contract Committee is FactRegistry, IAvailabilityVerifier, Identity {
    uint256 constant SIGNATURE_LENGTH = 32 * 2 + 1; // r(32) + s(32) +  v(1).
    uint256 public signaturesRequired;
    mapping(address => bool) public isMember;

    /// @dev Contract constructor sets initial members and required number of signatures.
    /// @param committeeMembers List of committee members.
    /// @param numSignaturesRequired Number of required signatures.
    constructor(address[] memory committeeMembers, uint256 numSignaturesRequired) public {
        require(numSignaturesRequired <= committeeMembers.length, "TOO_MANY_REQUIRED_SIGNATURES");
        for (uint256 idx = 0; idx < committeeMembers.length; idx++) {
            require(
                !isMember[committeeMembers[idx]] && (committeeMembers[idx] != address(0)),
                "NON_UNIQUE_COMMITTEE_MEMBERS"
            );
            isMember[committeeMembers[idx]] = true;
        }
        signaturesRequired = numSignaturesRequired;
    }

    

    /// @dev Verifies the availability proof. Reverts if invalid.
    /// An availability proof should have a form of a concatenation of ec-signatures by signatories.
    /// Signatures should be sorted by signatory address ascendingly.
    /// Signatures should be 65 bytes long. r(32) + s(32) + v(1).
    /// There should be at least the number of required signatures as defined in this contract
    /// and all signatures provided should be from signatories.
    ///
    /// See :sol:mod:`AvailabilityVerifiers` for more information on when this is used.
    ///
    /// @param claimHash The hash of the claim the committee is signing on.
    /// The format is keccak256(abi.encodePacked(
    ///    newValidiumVaultRoot, validiumTreeHeight, newOrderRoot, orderTreeHeight sequenceNumber))
    /// @param availabilityProofs Concatenated ec signatures by committee members.
    

    function bytesToBytes32(bytes memory array, uint256 offset)
        private
        pure
        returns (bytes32 result)
    {
        // Arrays are prefixed by a 256 bit length parameter.
        uint256 actualOffset = offset + 32;

        // Read the bytes32 from array memory.
        assembly {
            result := mload(add(array, actualOffset))
        }
    }
}
