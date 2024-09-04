pragma solidity 0.5.8;

/**
 * @title Contract used to store layout for the DummySTO storage
 */
contract DummySTOStorage {

    uint256 internal investorCount;

    uint256 internal cap;
    string public someString;

    mapping (address => uint256) public investors;

}
