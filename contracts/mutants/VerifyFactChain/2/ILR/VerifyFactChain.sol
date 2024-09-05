// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.12;

import "./MainStorage.sol";
import "../interfaces/IFactRegistry.sol";
import "../libraries/Common.sol";

contract VerifyFactChain is MainStorage {
    function verifyFact(
        StarkExTypes.ApprovalChainData storage chain,
        bytes32 fact,
        string memory noVerifiersErrorMessage,
        string memory invalidFactErrorMessage
    ) internal view {
        address[] storage list = chain.list;
        uint256 n_entries = list.length;
        require(n_entries > 1, noVerifiersErrorMessage);
        for (uint256 i = 1; i < n_entries; i++) {
            // NOLINTNEXTLINE: calls-loop.
            require(IFactRegistry(list[i]).isValid(fact), invalidFactErrorMessage);
        }
    }
}
