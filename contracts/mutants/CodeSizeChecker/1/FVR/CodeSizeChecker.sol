pragma solidity ^0.8.0;

contract CodeSizeChecker {
    function codeSize(address which) public view returns (uint256 ret) {
        // solhint-disable-next-line no-inline-assembly
        assembly {
            ret := extcodesize(which)
        }
    }
}
