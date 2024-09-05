// SPDX-License-Identifier: MIT
pragma solidity >=0.6.10 <0.8.0;
pragma experimental ABIEncoderV2;

import {IVotingEscrowCallback} from "../governance/VotingEscrowV2.sol";

contract VotingEscrowHelper is IVotingEscrowCallback {
    IVotingEscrowCallback public immutable ballot;
    IVotingEscrowCallback public immutable distributor0;
    IVotingEscrowCallback public immutable exchange0;
    IVotingEscrowCallback public immutable distributor1;
    IVotingEscrowCallback public immutable exchange1;
    IVotingEscrowCallback public immutable distributor2;
    IVotingEscrowCallback public immutable exchange2;

    

    function syncWithVotingEscrow(address account) external override {
        ballot.syncWithVotingEscrow(account);
        distributor0.syncWithVotingEscrow(account);
        exchange0.syncWithVotingEscrow(account);
        distributor1.syncWithVotingEscrow(account);
        exchange1.syncWithVotingEscrow(account);
        distributor2.syncWithVotingEscrow(account);
        exchange2.syncWithVotingEscrow(account);
    }
}
