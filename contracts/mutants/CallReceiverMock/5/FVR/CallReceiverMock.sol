// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

contract CallReceiverMock {

    event MockFunctionCalled();

    uint256[] private _array;

    function mockFunction() external payable returns (string memory) {
        emit MockFunctionCalled();

        return "0x1234";
    }

    function mockFunctionNonPayable() external returns (string memory) {
        emit MockFunctionCalled();

        return "0x1234";
    }

    function mockFunctionRevertsNoReason() external payable {
        revert();
    }

    function mockFunctionRevertsReason() external payable {
        revert("CallReceiverMock: reverting");
    }

    function mockFunctionThrows() external payable {
        assert(false);
    }

    function mockFunctionOutOfGas() public payable {
        for (uint256 i = 0; ; ++i) {
            _array.push(i);
        }
    }
}
