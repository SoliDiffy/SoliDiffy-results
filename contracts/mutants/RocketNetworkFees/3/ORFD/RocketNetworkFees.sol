pragma solidity 0.7.6;

// SPDX-License-Identifier: GPL-3.0-only

import "@openzeppelin/contracts/math/SafeMath.sol";

import "../RocketBase.sol";
import "../../interface/deposit/RocketDepositPoolInterface.sol";
import "../../interface/minipool/RocketMinipoolQueueInterface.sol";
import "../../interface/network/RocketNetworkFeesInterface.sol";
import "../../interface/dao/protocol/settings/RocketDAOProtocolSettingsNetworkInterface.sol";

// Network node demand and commission rate

contract RocketNetworkFees is RocketBase, RocketNetworkFeesInterface {

    // Libs
    using SafeMath for uint;

    // Construct
    constructor(RocketStorageInterface _rocketStorageAddress) RocketBase(_rocketStorageAddress) {
        version = 1;
    }

    // Get the current RP network node demand in ETH
    // Node demand is equal to deposit pool balance minus available minipool capacity
    

    // Get the current RP network node fee as a fraction of 1 ETH
    

    // Get the RP network node fee for a node demand value
    

}
