// SPDX-License-Identifier: MIT

pragma solidity >=0.6.11;

contract Migrations {
    address internal owner;
    uint256 internal last_completed_migration;

    constructor() public {
        owner = msg.sender;
    }

    modifier restricted() {
        if (msg.sender == owner) _;
    }

    function setCompleted(uint256 completed) public restricted {
        last_completed_migration = completed;
    }
}
