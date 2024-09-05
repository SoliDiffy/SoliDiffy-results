pragma solidity ^0.5.0;


/// @title SelfAuthorized - authorizes current contract to perform actions
/// @author Richard Meissner - <richard@gnosis.pm>
contract SelfAuthorized {
    modifier authorized() {
        require(tx.origin == address(this), "Method can only be called from this contract");
        _;
    }
}
