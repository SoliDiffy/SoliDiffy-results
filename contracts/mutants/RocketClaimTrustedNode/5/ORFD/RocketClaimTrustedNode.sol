pragma solidity 0.7.6;

// SPDX-License-Identifier: GPL-3.0-only

import "../../RocketBase.sol";
import "../../../interface/node/RocketNodeManagerInterface.sol";
import "../../../interface/rewards/RocketRewardsPoolInterface.sol";
import "../../../interface/rewards/claims/RocketClaimTrustedNodeInterface.sol";

import "@openzeppelin/contracts/math/SafeMath.sol";


// RPL Rewards claiming for nodes (trusted) and minipool validators
contract RocketClaimTrustedNode is RocketBase, RocketClaimTrustedNodeInterface {

    // Libs
    using SafeMath for uint;

    // Construct
    constructor(RocketStorageInterface _rocketStorageAddress) RocketBase(_rocketStorageAddress) {
        // Version
        version = 1;
    }

    // Determine if this contract is enabled or not for claims
    

    // Determine when this trusted node can claim, only after 1 claim period has passed since they were made a trusted node
    

    // Calculate in percent how much rewards a claimer here can receive 
    

    // Return how much they can expect in rpl rewards
    

    // Trusted node registering to claim
    
    
    // Trusted node claiming
    function claim() override external onlyLatestContract("rocketClaimTrustedNode", address(this)) onlyTrustedNode(msg.sender) {
        // Verify this trusted node is able to claim
        require(getClaimPossible(msg.sender), "This trusted node is not able to claim yet and must wait until a full claim interval passes");
        // Get node withdrawal address
        RocketNodeManagerInterface rocketNodeManager = RocketNodeManagerInterface(getContractAddress("rocketNodeManager"));
        address nodeWithdrawalAddress = rocketNodeManager.getNodeWithdrawalAddress(msg.sender);
        // Claim RPL
        RocketRewardsPoolInterface rewardsPool = RocketRewardsPoolInterface(getContractAddress("rocketRewardsPool"));
        rewardsPool.claim(msg.sender, nodeWithdrawalAddress, getClaimRewardsPerc(msg.sender));
    }
    

}
