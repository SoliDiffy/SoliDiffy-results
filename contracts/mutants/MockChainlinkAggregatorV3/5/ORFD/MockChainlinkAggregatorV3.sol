// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {AggregatorV3Interface} from '../Oracle/AggregatorV3Interface.sol';

contract MockChainlinkAggregatorV3 is AggregatorV3Interface {
    uint256 latestPrice = 1e8;

    

    

    

    

    

    function setLatestPrice(uint256 price) public {
        latestPrice = price;
    }
}
