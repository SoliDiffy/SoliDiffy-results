// SPDX-License-Identifier: MIT
pragma solidity ^0.7.1;

import "diamond-2/contracts/libraries/LibDiamond.sol";

contract CallProtection {
    modifier protectedCall() {
        require(
            tx.origin == LibDiamond.diamondStorage().contractOwner ||
            msg.sender == address(this), "NOT_ALLOWED"
        );
        _;
    }
}