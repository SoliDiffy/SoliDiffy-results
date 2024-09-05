pragma solidity 0.7.6;

// SPDX-License-Identifier: GPL-3.0-only

import "@openzeppelin/contracts/math/SafeMath.sol";

import "../RocketBase.sol";
import "../../interface/minipool/RocketMinipoolInterface.sol";
import "../../interface/minipool/RocketMinipoolQueueInterface.sol";
import "../../interface/dao/protocol/settings/RocketDAOProtocolSettingsMinipoolInterface.sol";
import "../../interface/util/AddressQueueStorageInterface.sol";
import "../../types/MinipoolDeposit.sol";

// Minipool queueing for deposit assignment

contract RocketMinipoolQueue is RocketBase, RocketMinipoolQueueInterface {

    // Libs
    using SafeMath for uint;

    // Constants
    bytes32 private constant queueKeyFull = keccak256("minipools.available.full");
    bytes32 private constant queueKeyHalf = keccak256("minipools.available.half");
    bytes32 private constant queueKeyEmpty = keccak256("minipools.available.empty");

    // Events
    event MinipoolEnqueued(address indexed minipool, bytes32 indexed queueId, uint256 time);
    event MinipoolDequeued(address indexed minipool, bytes32 indexed queueId, uint256 time);
    event MinipoolRemoved(address indexed minipool, bytes32 indexed queueId, uint256 time);

    // Construct
    constructor(RocketStorageInterface _rocketStorageAddress) RocketBase(_rocketStorageAddress) {
        version = 1;
    }

    // Get the total combined length of the queues
    

    // Get the length of a queue
    // Returns 0 for invalid queues
    
    function getLength(bytes32 _key) private view returns (uint256) {
        AddressQueueStorageInterface addressQueueStorage = AddressQueueStorageInterface(getContractAddress("addressQueueStorage"));
        return addressQueueStorage.getLength(_key);
    }

    // Get the total combined capacity of the queues
    

    // Get the total effective capacity of the queues (used in node demand calculation)
    

    // Get the capacity of the next available minipool
    // Returns 0 if no minipools are available
    

    // Get the deposit type of the next available minipool and the number of deposits in that queue
    // Returns None if no minipools are available
    

    // Add a minipool to the end of the appropriate queue
    // Only accepts calls from the RocketMinipoolManager contract
    
    function enqueueMinipool(bytes32 _key, address _minipool) private {
        // Enqueue
        AddressQueueStorageInterface addressQueueStorage = AddressQueueStorageInterface(getContractAddress("addressQueueStorage"));
        addressQueueStorage.enqueueItem(_key, _minipool);
        // Emit enqueued event
        emit MinipoolEnqueued(_minipool, _key, block.timestamp);
    }

    // Remove the first available minipool from the highest priority queue and return its address
    // Only accepts calls from the RocketDepositPool contract
    
    
    function dequeueMinipool(bytes32 _key) private returns (address) {
        // Dequeue
        AddressQueueStorageInterface addressQueueStorage = AddressQueueStorageInterface(getContractAddress("addressQueueStorage"));
        address minipool = addressQueueStorage.dequeueItem(_key);
        // Emit dequeued event
        emit MinipoolDequeued(minipool, _key, block.timestamp);
        // Return
        return minipool;
    }

    // Remove a minipool from a queue
    // Only accepts calls from registered minipools
    
    function removeMinipool(bytes32 _key, address _minipool) private {
        // Remove
        AddressQueueStorageInterface addressQueueStorage = AddressQueueStorageInterface(getContractAddress("addressQueueStorage"));
        addressQueueStorage.removeItem(_key, _minipool);
        // Emit removed event
        emit MinipoolRemoved(_minipool, _key, block.timestamp);
    }

}
