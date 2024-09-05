pragma solidity 0.7.6;

// SPDX-License-Identifier: GPL-3.0-only

import "./RocketMinipool.sol";
import "../RocketBase.sol";
import "../../interface/minipool/RocketMinipoolFactoryInterface.sol";
import "../../types/MinipoolDeposit.sol";

// Minipool contract factory

contract RocketMinipoolFactory is RocketBase, RocketMinipoolFactoryInterface {

    // Construct
    constructor(address _rocketStorageAddress) RocketBase(_rocketStorageAddress) {
        version = 1;
    }

    // Create a new RocketMinipool contract
    

}
