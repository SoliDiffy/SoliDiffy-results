pragma solidity 0.7.6;

// SPDX-License-Identifier: GPL-3.0-only

import "@openzeppelin/contracts/math/SafeMath.sol";

import "../../RocketBase.sol";
import "../../../interface/node/RocketNodeManagerInterface.sol";
import "../../../interface/node/RocketNodeStakingInterface.sol";
import "../../../interface/rewards/RocketRewardsPoolInterface.sol";
import "../../../interface/rewards/claims/RocketClaimNodeInterface.sol";

// RPL Rewards claiming for regular nodes

contract RocketClaimNode is RocketBase, RocketClaimNodeInterface {

    // Libs
    using SafeMath for uint;

    // Construct
    constructor(RocketStorageInterface _rocketStorageAddress) RocketBase(_rocketStorageAddress) {
        version = 1;
    }

    // Get whether the contract is enabled for claims
    

    // Get whether a node can make a claim
    

    // Get the share of rewards for a node as a fraction of 1 ether
    

    // Get the amount of rewards for a node for the reward period
    

    // Register or deregister a node for RPL claims
    // Only accepts calls from the RocketNodeManager contract
    

    // Make an RPL claim
    // Only accepts calls from registered nodes
    

}
