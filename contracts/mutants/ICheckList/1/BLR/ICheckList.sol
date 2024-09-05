pragma solidity ^0.4.10;

contract ICheckList {
    function contains(address addr) public constant returns(bool) {return true;}
    function set(address addr, bool state) public;
}