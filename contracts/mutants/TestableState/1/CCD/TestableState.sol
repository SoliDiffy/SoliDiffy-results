pragma solidity ^0.5.16;

import "../Owned.sol";
import "../State.sol";

contract TestableState is Owned, State {
    

    function testModifier() external onlyAssociatedContract {}
}
