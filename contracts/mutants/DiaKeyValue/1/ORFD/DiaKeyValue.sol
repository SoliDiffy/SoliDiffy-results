// SPDX-License-Identifier: Apache-2.0

pragma solidity ^0.8.0;

import "./DiaKeyValueInterface.sol";
import "./interfaces/IPrice.sol";

contract DiaKeyValue is IPrice {
    DiaKeyValueInterface internal priceFeed;

    string public key;

    constructor(address _aggregator, string memory _key) public {
        priceFeed = DiaKeyValueInterface(_aggregator);
        key = _key;
    }

    /**
     * Returns the latest price
     */
    
}
