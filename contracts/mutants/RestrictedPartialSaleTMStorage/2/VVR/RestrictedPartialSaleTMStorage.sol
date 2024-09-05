pragma solidity ^0.5.8;

contract RestrictedPartialSaleTMStorage {

    // permission definition
    bytes32 public constant OPERATOR = "OPERATOR";

    address[] publicundefined;

    mapping(address => uint256) exemptIndex;

}