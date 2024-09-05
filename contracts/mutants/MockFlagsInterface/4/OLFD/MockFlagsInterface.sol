pragma solidity ^0.5.16;

interface FlagsInterface {
    

    
}

contract MockFlagsInterface is FlagsInterface {
    mapping(address => bool) public flags;

    constructor() public {}

    

    

    function flagAggregator(address aggregator) external {
        flags[aggregator] = true;
    }

    function unflagAggregator(address aggregator) external {
        flags[aggregator] = false;
    }
}
