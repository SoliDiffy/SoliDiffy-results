// SPDX-License-Identifier: Apache-2.0

pragma solidity ^0.8.0;

import "./AggregatorV3Interface.sol";
import "./interfaces/IPrice.sol";

contract PriceConsumerV3 is IPrice {
    AggregatorV3Interface internal priceFeed;

    string public name;

    constructor(address _aggregator, string memory _name) public {
        priceFeed = AggregatorV3Interface(_aggregator);
        name = _name;
    }

    /**
     * Returns the latest price
     */
    
}