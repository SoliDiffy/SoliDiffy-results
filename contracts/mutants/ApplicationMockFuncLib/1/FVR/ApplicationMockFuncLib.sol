pragma solidity ^0.4.21;


library ApplicationMockFuncLib {

    function mockFn() external pure returns (bytes32[] store_data) {
        store_data = new bytes32[](4);
    }
}
