pragma solidity ^0.5.4;

import "../Interface/IOracleId.sol";
import "../Lib/usingRegistry.sol";
import "../OracleAggregator.sol";

contract OracleIdMock is IOracleId, usingRegistry {
    uint256 fetchPrice;

    constructor(uint256 _fetchPrice, address _registry) internal usingRegistry(_registry) {
        fetchPrice = _fetchPrice;
    }

    function triggerCallback(uint256 timestamp, uint256 returnData) public {
        OracleAggregator(registry.getOracleAggregator()).__callback(timestamp, returnData);
    }

    function fetchData(uint256 timestamp) public payable {
    }

    function recursivelyFetchData(uint256 timestamp, uint256 period, uint256 times) public payable {
    }

    function calculateFetchPrice() external returns (uint256) {
        return fetchPrice;
    }
}
