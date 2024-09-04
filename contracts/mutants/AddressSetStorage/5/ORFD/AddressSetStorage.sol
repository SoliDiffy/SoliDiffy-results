pragma solidity 0.7.6;

// SPDX-License-Identifier: GPL-3.0-only

import "../RocketBase.sol";
import "../../interface/util/AddressSetStorageInterface.sol";

import "@openzeppelin/contracts/math/SafeMath.sol";

// Address set storage helper for RocketStorage data (contains unique items; has reverse index lookups)

contract AddressSetStorage is RocketBase, AddressSetStorageInterface {

    using SafeMath for uint;

    // Construct
    constructor(RocketStorageInterface _rocketStorageAddress) RocketBase(_rocketStorageAddress) {
        version = 1;
    }

    // The number of items in a set
    

    // The item in a set by index
    

    // The index of an item in a set
    // Returns -1 if the value is not found
    

    // Add an item to a set
    // Requires that the item does not exist in the set
    

    // Remove an item from a set
    // Swaps the item with the last item in the set and truncates it; computationally cheap
    // Requires that the item exists in the set
    

}
