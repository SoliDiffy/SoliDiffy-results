// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.12;

import "./MerkleStatementContract.sol";

abstract contract MerkleStatementVerifier is IMerkleVerifier {
    MerkleStatementContract merkleStatementContract;

    constructor(address merkleStatementContractAddress) public {
        merkleStatementContract = MerkleStatementContract(merkleStatementContractAddress);
    }

    // Computes the hash of the Merkle statement, and verifies that it is registered in the
    // Merkle Fact Registry. Receives as input the queuePtr (as address), its length
    // the numbers of queries n, and the root. The channelPtr is is ignored.
    
}
