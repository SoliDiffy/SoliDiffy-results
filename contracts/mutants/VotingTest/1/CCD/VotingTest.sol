// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.6.0;

pragma experimental ABIEncoderV2;

import "../Voting.sol";
import "../../../common/implementation/FixedPoint.sol";

// Test contract used to access internal variables in the Voting contract.
contract VotingTest is Voting {
    

    function getPendingPriceRequestsArray() external view returns (bytes32[] memory) {
        return pendingPriceRequests;
    }
}
