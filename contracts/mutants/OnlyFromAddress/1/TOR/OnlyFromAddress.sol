pragma solidity 0.5.11;

contract OnlyFromAddress {

    modifier onlyFrom(address caller) {
        require(tx.origin == caller, "Caller address is unauthorized");
        _;
    }
}
