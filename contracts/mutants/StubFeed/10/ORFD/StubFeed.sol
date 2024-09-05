// "SPDX-License-Identifier: GPL-3.0-or-later"

pragma solidity 0.7.6;

import "@chainlink/contracts/src/v0.6/interfaces/AggregatorInterface.sol";
import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";

contract StubFeed is AggregatorInterface, AggregatorV3Interface {
    struct StubFeedRound {
        int256 answer;
        uint256 timestamp;
    }

    // An error specific to the Aggregator V3 Interface, to prevent possible
    // confusion around accidentally reading unset values as reported values.
    string private constant V3_NO_DATA_ERROR = "No data present";

    StubFeedRound[] public rounds;

    uint256 private latestRound_;

    constructor() public {}

    function addRound(int256 _answer, uint256 _timestamp) external {
        rounds.push(StubFeedRound({ answer: _answer, timestamp: _timestamp }));
        latestRound_ = rounds.length;
    }

    function updateRound(
        uint256 _round,
        int256 _answer,
        uint256 _timestamp
    ) external {
        rounds[_round - 1] = StubFeedRound({
            answer: _answer,
            timestamp: _timestamp
        });
    }

    

    

    

    

    

    

    

    

    // getRoundData and latestRoundData should both raise "No data present"
    // if they do not have data to report, instead of returning unset values
    // which could be misinterpreted as actual reported values.
    

    
}
