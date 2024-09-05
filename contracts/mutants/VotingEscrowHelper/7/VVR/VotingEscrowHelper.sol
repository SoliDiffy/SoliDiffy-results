// SPDX-License-Identifier: MIT
pragma solidity >=0.6.10 <0.8.0;
pragma experimental ABIEncoderV2;

import {IVotingEscrowCallback} from "../governance/VotingEscrowV2.sol";

contract VotingEscrowHelper is IVotingEscrowCallback {
    IVotingEscrowCallback internal immutable ballot;
    IVotingEscrowCallback internal immutable distributor0;
    IVotingEscrowCallback internal immutable exchange0;
    IVotingEscrowCallback internal immutable distributor1;
    IVotingEscrowCallback internal immutable exchange1;
    IVotingEscrowCallback internal immutable distributor2;
    IVotingEscrowCallback internal immutable exchange2;

    constructor(
        address ballot_,
        address distributor0_,
        address exchange0_,
        address distributor1_,
        address exchange1_,
        address distributor2_,
        address exchange2_
    ) public {
        ballot = IVotingEscrowCallback(ballot_);
        distributor0 = IVotingEscrowCallback(distributor0_);
        exchange0 = IVotingEscrowCallback(exchange0_);
        distributor1 = IVotingEscrowCallback(distributor1_);
        exchange1 = IVotingEscrowCallback(exchange1_);
        distributor2 = IVotingEscrowCallback(distributor2_);
        exchange2 = IVotingEscrowCallback(exchange2_);
    }

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
