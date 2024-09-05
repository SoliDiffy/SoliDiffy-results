pragma solidity ^0.4.4;
//SWC-101-Integer Overflow and Underflow:L1-69
import "./Token.sol";

contract GNTAllocation {
    // Total number of allocations to distribute additional tokens among
    // developers and the Golem Factory. The Golem Factory has right to 20000
    // allocations, developers to 10000 allocations, divides among individual
    // developers by numbers specified in  `allocations` table.
    uint256 constant totalAllocations = 30000;

    // Addresses of developer and the Golem Factory to allocations mapping.
    mapping (address => uint256) allocations;

    GolemNetworkToken gnt;
    uint256 unlockedAt;

    uint256 tokensCreated = 0;

    

    // Allows developer to unlock its allocated tokens by transferring them back
    // to developer's address.
    function unlock() external {
        if (now < unlockedAt) throw;

        // During first unlock attempt fetch total number of locked tokens.
        if (tokensCreated == 0)
            tokensCreated = gnt.balanceOf(this);

        var allocation = allocations[msg.sender];
        allocations[msg.sender] = 0;
        var toTransfer = tokensCreated * allocation / totalAllocations;

        // Will fail if allocation (and therefore toTransfer) is 0.
        if (!gnt.transfer(msg.sender, toTransfer)) throw;
    }
}
