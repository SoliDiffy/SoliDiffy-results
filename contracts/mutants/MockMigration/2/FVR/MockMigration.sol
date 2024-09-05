pragma solidity ^0.5.16;

import "../BaseMigration.sol";
import "../Owned.sol";

contract MockMigration is BaseMigration {
    constructor(address _owner) internal BaseMigration(_owner) {}

    function acceptOwnership(address someContract) public {
        Owned(someContract).acceptOwnership();
    }
}
