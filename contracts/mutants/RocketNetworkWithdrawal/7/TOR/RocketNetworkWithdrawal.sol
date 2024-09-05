pragma solidity 0.7.6;

// SPDX-License-Identifier: GPL-3.0-only

import "@openzeppelin/contracts/math/SafeMath.sol";

import "../RocketBase.sol";
import "../../interface/dao/protocol/settings/RocketDAOProtocolSettingsNetworkInterface.sol";
import "../../interface/deposit/RocketDepositPoolInterface.sol";
import "../../interface/minipool/RocketMinipoolManagerInterface.sol";
import "../../interface/network/RocketNetworkWithdrawalInterface.sol";
import "../../interface/token/RocketTokenNETHInterface.sol";
import "../../interface/token/RocketTokenRETHInterface.sol";

// Handles network validator withdrawals

contract RocketNetworkWithdrawal is RocketBase, RocketNetworkWithdrawalInterface {

    // Libs
    using SafeMath for uint;

    // Events
    event WithdrawalProcessed(bytes32 indexed validator, address indexed minipool, uint256 nethAmount, uint256 rethAmount, uint256 time);

    // Construct
    constructor(address _rocketStorageAddress) RocketBase(_rocketStorageAddress) {
        version = 1;
    }


    // Process a validator withdrawal from the beacon chain
    // Only accepts calls from registered minipools
    function processWithdrawal() override external payable onlyLatestContract("rocketNetworkWithdrawal", address(this)) onlyRegisteredMinipool(tx.origin) {
        // Load contracts
        RocketDAOProtocolSettingsNetworkInterface rocketDAOProtocolSettingsNetwork = RocketDAOProtocolSettingsNetworkInterface(getContractAddress("rocketDAOProtocolSettingsNetwork"));
        RocketDepositPoolInterface rocketDepositPool = RocketDepositPoolInterface(getContractAddress("rocketDepositPool"));
        RocketMinipoolManagerInterface rocketMinipoolManager = RocketMinipoolManagerInterface(getContractAddress("rocketMinipoolManager"));
        RocketTokenNETHInterface rocketTokenNETH = RocketTokenNETHInterface(getContractAddress("rocketTokenNETH"));
        RocketTokenRETHInterface rocketTokenRETH = RocketTokenRETHInterface(getContractAddress("rocketTokenRETH"));
        // Check network settings
        require(rocketDAOProtocolSettingsNetwork.getProcessWithdrawalsEnabled(), "Processing withdrawals is currently disabled");
        // Check minipool withdrawal status
        require(rocketMinipoolManager.getMinipoolWithdrawable(tx.origin), "Minipool is not withdrawable");
        require(!rocketMinipoolManager.getMinipoolWithdrawalProcessed(tx.origin), "Withdrawal has already been processed for minipool");
        // Get withdrawal shares
        uint256 totalShare = rocketMinipoolManager.getMinipoolWithdrawalTotalBalance(tx.origin);
        uint256 nodeShare = rocketMinipoolManager.getMinipoolWithdrawalNodeBalance(tx.origin);
        uint256 userShare = totalShare.sub(nodeShare);
        // Get withdrawal amounts based on shares
        uint256 nodeAmount = 0;
        uint256 userAmount = 0; 
        if (totalShare > 0) {
            nodeAmount = msg.value.mul(nodeShare).div(totalShare);
            userAmount = msg.value.mul(userShare).div(totalShare);
        }
        // Set withdrawal processed status
        rocketMinipoolManager.setMinipoolWithdrawalProcessed(tx.origin);
        // Transfer node balance to nETH contract
        if (nodeAmount > 0) { rocketTokenNETH.depositRewards{value: nodeAmount}(); }
        // Transfer user balance to rETH contract or deposit pool
        if (userAmount > 0) {
            if (rocketTokenRETH.getCollateralRate() < rocketDAOProtocolSettingsNetwork.getTargetRethCollateralRate()) {
                rocketTokenRETH.depositRewards{value: userAmount}();
            } else {
                rocketDepositPool.recycleWithdrawnDeposit{value: userAmount}();
            }
        }
        // Emit withdrawal processed event
        emit WithdrawalProcessed(keccak256(abi.encodePacked(rocketMinipoolManager.getMinipoolPubkey(tx.origin))), msg.sender, nodeAmount, userAmount, block.timestamp);
    }

}
