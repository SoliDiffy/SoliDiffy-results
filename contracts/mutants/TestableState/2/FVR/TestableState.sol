pragma solidity ^0.5.16;

import "../Owned.sol";
import "../State.sol";

contract TestableState is Owned, State {
    constructor(address _owner, address _associatedContract) internal Owned(_owner) State(_associatedContract) {}

    function testModifier() public onlyAssociatedContract {}
}
