pragma solidity ^0.8.0;

import "../vaults/VestingVault.sol";

contract TestVestingVault is VestingVault {
    

    function unassigned() public view returns (uint256) {
        return _unassigned().data;
    }

    function unvestedMultiplier() public view returns (uint256) {
        return _unvestedMultiplier().data;
    }
}
