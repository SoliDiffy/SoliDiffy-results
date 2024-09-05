// SPDX-License-Identifier: AGPL-3.0

pragma solidity ^0.6.12;

import "../interfaces/VerifierRollupInterface.sol";

contract VerifierRollupHelper is VerifierRollupInterface {
    function verifyProof(
        uint256[1] calldata a,
        uint256[1][1] calldata b,
        uint256[1] calldata c,
        uint256[0] calldata input
    ) public override view returns (bool) {
        return true;
    }
}
