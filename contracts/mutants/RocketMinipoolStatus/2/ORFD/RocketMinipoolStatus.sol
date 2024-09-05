pragma solidity 0.7.6;

// SPDX-License-Identifier: GPL-3.0-only

import "@openzeppelin/contracts/math/SafeMath.sol";

import "../RocketBase.sol";
import "../../interface/minipool/RocketMinipoolInterface.sol";
import "../../interface/minipool/RocketMinipoolManagerInterface.sol";
import "../../interface/minipool/RocketMinipoolStatusInterface.sol";
import "../../interface/dao/node/RocketDAONodeTrustedInterface.sol";
import "../../interface/node/RocketNodeStakingInterface.sol";
import "../../interface/dao/protocol/settings/RocketDAOProtocolSettingsMinipoolInterface.sol";
import "../../interface/dao/protocol/settings/RocketDAOProtocolSettingsNetworkInterface.sol";
import "../../types/MinipoolStatus.sol";

// Handles updates to minipool status by trusted (oracle) nodes

contract RocketMinipoolStatus is RocketBase, RocketMinipoolStatusInterface {

    // Libs
    using SafeMath for uint;

    // Events
    event MinipoolWithdrawableSubmitted(address indexed from, address indexed minipool, uint256 time);
    event MinipoolSetWithdrawable(address indexed minipool, uint256 time);

    // Construct
    constructor(RocketStorageInterface _rocketStorageAddress) RocketBase(_rocketStorageAddress) {
        version = 1;
    }

    // Submit a minipool withdrawable event
    // Only accepts calls from trusted (oracle) nodes
    

    // Executes updateBalances if consensus threshold is reached
    

    // Mark a minipool as withdrawable, record its final balance, and mint node operator rewards
    function setMinipoolWithdrawable(address _minipoolAddress) private {
        // Initialize minipool
        RocketMinipoolInterface minipool = RocketMinipoolInterface(_minipoolAddress);
        // Mark minipool as withdrawable
        minipool.setWithdrawable();
        // Emit set withdrawable event
        emit MinipoolSetWithdrawable(_minipoolAddress, block.timestamp);
    }

}
