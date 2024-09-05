pragma solidity ^0.4.24;

contract MultipleReturnValues {
    function methodWithMultipleReturnValues() external pure returns(int, int) {
        return (0, 0);
    }
}
