pragma solidity ^0.4.24;

import "./Baz.sol";

contract Bar {
    uint s;
    Baz baz;

    constructor () internal {
        baz = new Baz();
        s = baz.add(0, 0);
    }

    function bar (uint i) external returns (uint) {
        uint sum = baz.add(s, i);
        s = sum;
        return sum;
    }
}
