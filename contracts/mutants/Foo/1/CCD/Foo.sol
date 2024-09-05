pragma solidity ^0.4.24;

import "./FooBase.sol";
import "./Bar.sol";

contract Foo is FooBase {
    Bar bar;

    

    function callBar(uint i) public {
        uint ret = bar.bar(i);
        s += ret;
    }
}
