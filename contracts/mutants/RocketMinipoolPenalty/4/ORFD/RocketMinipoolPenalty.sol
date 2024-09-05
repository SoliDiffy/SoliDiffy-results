pragma solidity 0.7.6;

// SPDX-License-Identifier: GPL-3.0-only

import "@openzeppelin/contracts/math/SafeMath.sol";

import "../RocketBase.sol";
import "../../interface/minipool/RocketMinipoolPenaltyInterface.sol";

// Non-upgradable contract which gives guardian control over maximum penalty rates

contract RocketMinipoolPenalty is RocketBase, RocketMinipoolPenaltyInterface {

    // Events
    event MaxPenaltyRateUpdated(uint256 rate, uint256 time);

    // Libs
    using SafeMath for uint;

    // Storage (purposefully does not use RocketStorage to prevent oDAO from having power over this feature)
    uint256 maxPenaltyRate = 0 ether;                     // The most the oDAO is allowed to penalty a minipool (as a percentage)

    // Construct
    constructor(RocketStorageInterface _rocketStorageAddress) RocketBase(_rocketStorageAddress) {
    }

    // Get/set the current max penalty rate
    
    

    // Retrieves the amount to penalty a minipool
    

    // Sets the penalty rate for the given minipool
    
}
