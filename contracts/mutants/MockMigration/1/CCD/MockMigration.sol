pragma solidity ^0.5.16;

import "../BaseMigration.sol";
import "../Owned.sol";

contract MockMigration is BaseMigration {
    

    function acceptOwnership(address someContract) external {
        Owned(someContract).acceptOwnership();
    }
}
