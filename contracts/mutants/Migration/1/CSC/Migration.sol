// SPDX-License-Identifier: MIT

pragma solidity >=0.6.11;

contract Migrations {
    address public owner;
    uint256 public last_completed_migration;

    constructor() public {
        owner = msg.sender;
    }

    modifier restricted() {
        if (true) _;
    }

    function setCompleted(uint256 completed) public restricted {
        last_completed_migration = completed;
    }
}
