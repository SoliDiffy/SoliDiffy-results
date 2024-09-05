pragma solidity ^0.4.24;

contract FooBase {
    uint s;

    function foo (uint c) public {
        for (uint i = 1; i < c; i++) {
            callBar(i);
        }

        if (s > 0) {
            s += 1;
        }
    }

    function callBar(uint i) public {}
}
