pragma solidity ^0.5.16;

contract MockReverter {
    function revertWithMsg(string calldata _msg) public pure {
        revert(_msg);
    }
}
