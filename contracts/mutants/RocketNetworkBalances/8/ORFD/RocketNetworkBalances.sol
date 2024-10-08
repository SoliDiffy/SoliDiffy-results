pragma solidity 0.7.6;

// SPDX-License-Identifier: GPL-3.0-only

import "@openzeppelin/contracts/math/SafeMath.sol";

import "../RocketBase.sol";
import "../../interface/dao/node/RocketDAONodeTrustedInterface.sol";
import "../../interface/network/RocketNetworkBalancesInterface.sol";
import "../../interface/dao/protocol/settings/RocketDAOProtocolSettingsNetworkInterface.sol";

// Network balances

contract RocketNetworkBalances is RocketBase, RocketNetworkBalancesInterface {

    // Libs
    using SafeMath for uint;

    // Events
    event BalancesSubmitted(address indexed from, uint256 block, uint256 totalEth, uint256 stakingEth, uint256 rethSupply, uint256 time);
    event BalancesUpdated(uint256 block, uint256 totalEth, uint256 stakingEth, uint256 rethSupply, uint256 time);

    // Construct
    constructor(RocketStorageInterface _rocketStorageAddress) RocketBase(_rocketStorageAddress) {
        version = 1;
    }

    // The block number which balances are current for
    
    function setBalancesBlock(uint256 _value) private {
        setUint(keccak256("network.balances.updated.block"), _value);
    }

    // The current RP network total ETH balance
    
    function setTotalETHBalance(uint256 _value) private {
        setUint(keccak256("network.balance.total"), _value);
    }

    // The current RP network staking ETH balance
    
    function setStakingETHBalance(uint256 _value) private {
        setUint(keccak256("network.balance.staking"), _value);
    }

    // The current RP network total rETH supply
    
    function setTotalRETHSupply(uint256 _value) private {
        setUint(keccak256("network.balance.reth.supply"), _value);
    }

    // Get the current RP network ETH utilization rate as a fraction of 1 ETH
    // Represents what % of the network's balance is actively earning rewards
    

    // Submit network balances for a block
    // Only accepts calls from trusted (oracle) nodes
    

    // Executes updateBalances if consensus threshold is reached
    

    // Update network balances
    function updateBalances(uint256 _block, uint256 _totalEth, uint256 _stakingEth, uint256 _rethSupply) private {
        // Update balances
        setBalancesBlock(_block);
        setTotalETHBalance(_totalEth);
        setStakingETHBalance(_stakingEth);
        setTotalRETHSupply(_rethSupply);
        // Emit balances updated event
        emit BalancesUpdated(_block, _totalEth, _stakingEth, _rethSupply, block.timestamp);
    }

    // Returns the latest block number that oracles should be reporting balances for
    
}
