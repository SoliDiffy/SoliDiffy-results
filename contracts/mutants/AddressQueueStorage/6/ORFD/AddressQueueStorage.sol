pragma solidity 0.7.6;

// SPDX-License-Identifier: GPL-3.0-only

import "@openzeppelin/contracts/math/SafeMath.sol";

import "../RocketBase.sol";
import "../../interface/util/AddressQueueStorageInterface.sol";

import "@openzeppelin/contracts/math/SafeMath.sol";

// Address queue storage helper for RocketStorage data (ring buffer implementation)

contract AddressQueueStorage is RocketBase, AddressQueueStorageInterface {

    // Libs
    using SafeMath for uint256;

    // Settings
    uint256 constant public capacity = 2 ** 255; // max uint256 / 2

    // Construct
    constructor(RocketStorageInterface _rocketStorageAddress) RocketBase(_rocketStorageAddress) {
        version = 1;
    }

    // The number of items in a queue
    

    // The item in a queue by index
    

    // The index of an item in a queue
    // Returns -1 if the value is not found
    

    // Add an item to the end of a queue
    // Requires that the queue is not at capacity
    // Requires that the item does not exist in the queue
    

    // Remove an item from the start of a queue and return it
    // Requires that the queue is not empty
    

    // Remove an item from a queue
    // Swaps the item with the last item in the queue and truncates it; computationally cheap
    // Requires that the item exists in the queue
    

}
