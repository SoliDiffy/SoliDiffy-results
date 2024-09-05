pragma solidity 0.7.6;

// SPDX-License-Identifier: GPL-3.0-only

import "@openzeppelin/contracts/math/SafeMath.sol";

import "../RocketBase.sol";
import "../../interface/dao/node/RocketDAONodeTrustedInterface.sol";
import "../../interface/network/RocketNetworkPricesInterface.sol";
import "../../interface/dao/protocol/settings/RocketDAOProtocolSettingsNetworkInterface.sol";

// Network token price data

contract RocketNetworkPrices is RocketBase, RocketNetworkPricesInterface {

    // Libs
    using SafeMath for uint;

    // Events
    event PricesSubmitted(address indexed from, uint256 block, uint256 rplPrice, uint256 effectiveRplStake, uint256 time);
    event PricesUpdated(uint256 block, uint256 rplPrice, uint256 effectiveRplStake, uint256 time);

    // Construct
    constructor(RocketStorageInterface _rocketStorageAddress) RocketBase(_rocketStorageAddress) {
        // Set contract version
        version = 1;
        // Set initial RPL price
        setRPLPrice(0.01 ether);
    }

    // The block number which prices are current for
    
    function setPricesBlock(uint256 _value) private {
        setUint(keccak256("network.prices.updated.block"), _value);
    }

    // The current RP network RPL price in ETH
    
    function setRPLPrice(uint256 _value) private {
        setUint(keccak256("network.prices.rpl"), _value);
    }

    // The current RP network effective RPL stake
    
    
    function setEffectiveRPLStake(uint256 _value) private {
        setUint(keccak256("network.rpl.stake"), _value);
        setUint(keccak256("network.rpl.stake.updated.block"), block.number);
    }
    
    

    // Submit network price data for a block
    // Only accepts calls from trusted (oracle) nodes
    

    // Executes updatePrices if consensus threshold is reached
    

    // Update network price data
    function updatePrices(uint256 _block, uint256 _rplPrice, uint256 _effectiveRplStake) private {
        // Ensure effective stake hasn't been updated on chain since `_block`
        require(_block >= getEffectiveRPLStakeUpdatedBlock(), "Cannot update effective RPL stake based on block lower than when it was last updated on chain");
        // Update price and effective RPL stake
        setRPLPrice(_rplPrice);
        setPricesBlock(_block);
        setEffectiveRPLStake(_effectiveRplStake);
        // Emit prices updated event
        emit PricesUpdated(_block, _rplPrice, _effectiveRplStake, block.timestamp);
    }

    // Returns true if consensus has been reached for the last price reportable block
    function inConsensus() override public view returns (bool) {
        // Load contracts
        RocketDAOProtocolSettingsNetworkInterface rocketDAOProtocolSettingsNetwork = RocketDAOProtocolSettingsNetworkInterface(getContractAddress("rocketDAOProtocolSettingsNetwork"));
        // Get the block prices were lasted updated and the update frequency
        uint256 pricesBlock = getPricesBlock();
        uint256 updateFrequency = rocketDAOProtocolSettingsNetwork.getSubmitPricesFrequency();
        // Calculate the last reportable block (we are still in consensus if this transaction is WITHIN the next reportable block, hence the subtract 1)
        uint256 latestReportableBlock = block.number.sub(1).div(updateFrequency).mul(updateFrequency);
        // If we've passed into a new window then we are waiting for oracles to report the next price
        return pricesBlock >= latestReportableBlock;
    }

    // Returns the latest block number that oracles should be reporting prices for
    function getLatestReportableBlock() override external view returns (uint256) {
        // Load contracts
        RocketDAOProtocolSettingsNetworkInterface rocketDAOProtocolSettingsNetwork = RocketDAOProtocolSettingsNetworkInterface(getContractAddress("rocketDAOProtocolSettingsNetwork"));
        // Get the block prices were lasted updated and the update frequency
        uint256 pricesBlock = getPricesBlock();
        uint256 updateFrequency = rocketDAOProtocolSettingsNetwork.getSubmitPricesFrequency();
        // Calculate the last reportable block based on update frequency
        uint256 latestReportableBlock = block.number.div(updateFrequency).mul(updateFrequency);
        // There is an edge case where the update frequency is modified by the DAO and the latest reportable block calculated
        // via the above method is older than the most recent block the effective RPL stake was updated on chain. If we don't
        // handle that then price updates will fail for that block
        uint256 lastOnChainUpdate = getEffectiveRPLStakeUpdatedBlock();
        if (pricesBlock < latestReportableBlock && lastOnChainUpdate > latestReportableBlock) {
            return lastOnChainUpdate;
        }
        return latestReportableBlock;
    }
}
