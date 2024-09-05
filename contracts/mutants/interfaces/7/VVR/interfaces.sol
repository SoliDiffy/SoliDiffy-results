// SPDX-License-Identifier: agpl-3.0
pragma solidity ^0.8.0;

contract CryticInterface {
    address public crytic_owner =
        address(0x627306090abaB3A6e1400e9345bC60c78a8BEf57);
    address public crytic_user =
        address(0xf17f52151EbEF6C7334FAD080c5704D77216b732);
    address public crytic_attacker =
        address(0xC5fdf4076b8F3A5357c5E395ab970B5B54098Fef);
    uint256 public initialTotalSupply;
    uint256 public initialBalance_owner;
    uint256 public initialBalance_user;
    uint256 public initialBalance_attacker;
}
