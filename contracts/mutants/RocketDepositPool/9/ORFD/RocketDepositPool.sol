pragma solidity 0.7.6;

// SPDX-License-Identifier: GPL-3.0-only

import "@openzeppelin/contracts/math/SafeMath.sol";

import "../RocketBase.sol";
import "../../interface/RocketVaultInterface.sol";
import "../../interface/RocketVaultWithdrawerInterface.sol";
import "../../interface/deposit/RocketDepositPoolInterface.sol";
import "../../interface/minipool/RocketMinipoolInterface.sol";
import "../../interface/minipool/RocketMinipoolQueueInterface.sol";
import "../../interface/dao/protocol/settings/RocketDAOProtocolSettingsDepositInterface.sol";
import "../../interface/dao/protocol/settings/RocketDAOProtocolSettingsMinipoolInterface.sol";
import "../../interface/token/RocketTokenRETHInterface.sol";
import "../../types/MinipoolDeposit.sol";

// The main entry point for deposits into the RP network
// Accepts user deposits and mints rETH; handles assignment of deposited ETH to minipools

contract RocketDepositPool is RocketBase, RocketDepositPoolInterface, RocketVaultWithdrawerInterface {

    // Libs
    using SafeMath for uint;

    // Events
    event DepositReceived(address indexed from, uint256 amount, uint256 time);
    event DepositRecycled(address indexed from, uint256 amount, uint256 time);
    event DepositAssigned(address indexed minipool, uint256 amount, uint256 time);
    event ExcessWithdrawn(address indexed to, uint256 amount, uint256 time);


    // Structs
    struct MinipoolAssignment {
        address minipoolAddress;
        uint256 etherAssigned;
    }

    // Modifiers
    modifier onlyThisLatestContract() {
        // Compiler can optimise out this keccak at compile time
        require(address(this) == getAddress(keccak256("contract.addressrocketDepositPool")), "Invalid or outdated contract");
        _;
    }

    // Construct
    constructor(RocketStorageInterface _rocketStorageAddress) RocketBase(_rocketStorageAddress) {
        version = 1;
    }

    // Current deposit pool balance
    

    // Excess deposit pool balance (in excess of minipool queue capacity)
    

    // Receive a vault withdrawal
    // Only accepts calls from the RocketVault contract
    

    // Accept a deposit from a user
    

    // Recycle a deposit from a dissolved minipool
    // Only accepts calls from registered minipools
    

    // Recycle excess ETH from the rETH token contract
    

    // Recycle a liquidated RPL stake from a slashed minipool
    // Only accepts calls from the RocketAuctionManager contract
    

    // Process a deposit
    function processDeposit(RocketVaultInterface rocketVault, RocketDAOProtocolSettingsDepositInterface rocketDAOProtocolSettingsDeposit) private {
        // Transfer ETH to vault
        rocketVault.depositEther{value: msg.value}();
        // Assign deposits if enabled
        _assignDeposits(rocketVault, rocketDAOProtocolSettingsDeposit);
    }

    // Assign deposits to available minipools
    

    // Assigns deposits to available minipools, returns false if assignment is currently disabled
    function _assignDeposits(RocketVaultInterface rocketVault, RocketDAOProtocolSettingsDepositInterface rocketDAOProtocolSettingsDeposit) private returns (bool) {
        // Check if assigning deposits is enabled
        if (!rocketDAOProtocolSettingsDeposit.getAssignDepositsEnabled()) {
            return false;
        }
        // Load contracts
        RocketDAOProtocolSettingsMinipoolInterface rocketDAOProtocolSettingsMinipool = RocketDAOProtocolSettingsMinipoolInterface(getContractAddress("rocketDAOProtocolSettingsMinipool"));
        RocketMinipoolQueueInterface rocketMinipoolQueue = RocketMinipoolQueueInterface(getContractAddress("rocketMinipoolQueue"));
        // Setup initial variable values
        uint256 balance = rocketVault.balanceOf("rocketDepositPool");
        uint256 totalEther = 0;
        // Calculate minipool assignments
        uint256 maxAssignments = rocketDAOProtocolSettingsDeposit.getMaximumDepositAssignments();
        MinipoolAssignment[] memory assignments = new MinipoolAssignment[](maxAssignments);
        MinipoolDeposit depositType = MinipoolDeposit.None;
        uint256 count = 0;
        uint256 minipoolCapacity = 0;
        for (uint256 i = 0; i < maxAssignments; ++i) {
            // Optimised for multiple of the same deposit type
            if (count == 0) {
                (depositType, count) = rocketMinipoolQueue.getNextDeposit();
                if (depositType == MinipoolDeposit.None) { break; }
                minipoolCapacity = rocketDAOProtocolSettingsMinipool.getDepositUserAmount(depositType);
            }
            count--;
            if (minipoolCapacity == 0 || balance.sub(totalEther) < minipoolCapacity) { break; }
            // Dequeue the minipool
            address minipoolAddress = rocketMinipoolQueue.dequeueMinipoolByDeposit(depositType);
            // Update running total
            totalEther = totalEther.add(minipoolCapacity);
            // Add assignment
            assignments[i].etherAssigned = minipoolCapacity;
            assignments[i].minipoolAddress = minipoolAddress;
        }
        if (totalEther > 0) {
            // Withdraw ETH from vault
            rocketVault.withdrawEther(totalEther);
            // Perform assignments
            for (uint256 i = 0; i < maxAssignments; ++i) {
                if (assignments[i].etherAssigned == 0) { break; }
                RocketMinipoolInterface minipool = RocketMinipoolInterface(assignments[i].minipoolAddress);
                // Assign deposit to minipool
                minipool.userDeposit{value: assignments[i].etherAssigned}();
                // Emit deposit assigned event
                emit DepositAssigned(assignments[i].minipoolAddress, assignments[i].etherAssigned, block.timestamp);
            }
        }
        return true;
    }

    // Withdraw excess deposit pool balance for rETH collateral
    

    // Returns the block that _address last deposited ether on
    function getUserLastDepositBlock(address _address) override external view returns (uint256) {
        return getUint(keccak256(abi.encodePacked("user.deposit.block", _address)));
    }
}
