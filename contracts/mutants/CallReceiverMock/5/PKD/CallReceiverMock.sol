// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

contract CallReceiverMock {

    event MockFunctionCalled();

    uint256[] private _array;

    function mockFunction() public  returns (string memory) {
        emit MockFunctionCalled();

        return "0x1234";
    }

    function mockFunctionNonPayable() public returns (string memory) {
        emit MockFunctionCalled();

        return "0x1234";
    }

    function mockFunctionRevertsNoReason() public  {
        revert();
    }

    function mockFunctionRevertsReason() public  {
        revert("CallReceiverMock: reverting");
    }

    function mockFunctionThrows() public  {
        assert(false);
    }

    function mockFunctionOutOfGas() public  {
        for (uint256 i = 0; ; ++i) {
            _array.push(i);
        }
    }
}
