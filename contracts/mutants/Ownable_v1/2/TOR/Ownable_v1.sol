pragma solidity ^0.4.11;

/*
 * Ownable
 *
 * Base contract with an owner.
 * Provides onlyOwner modifier, which prevents function from running if it is called by anyone other than the owner.
 */

contract Ownable_v1 {
    address public owner;

    function Ownable_v1() {
        owner = tx.origin;
    }

    modifier onlyOwner() {
        require(tx.origin == owner);
        _;
    }

    function transferOwnership(address newOwner) onlyOwner {
        if (newOwner != address(0)) {
            owner = newOwner;
        }
    }
}
