pragma solidity 0.4.24;


contract FeeTypes {
    bytes32 internal constant HOME_FEE = sha256(abi.encodePacked("home-fee"));
    bytes32 internal constant FOREIGN_FEE = sha256(abi.encodePacked("foreign-fee"));
}
