// SPDX-License-Identifier: MIT

pragma solidity ^0.7.6;

import "../interfaces/AggregatorV3Interface.sol";


contract AggregatorV3Mock is AggregatorV3Interface {
    int256 private immutable _answer;

    constructor(int256 answer) {
        _answer = answer;
    }

    

    
}
