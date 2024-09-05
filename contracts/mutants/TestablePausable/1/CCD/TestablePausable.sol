pragma solidity ^0.5.16;

import "../Owned.sol";
import "../Pausable.sol";

/**
 * @title An implementation of Pausable. Used to test the features of the Pausable contract that can only be tested by an implementation.
 */
contract TestablePausable is Owned, Pausable {
    uint public someValue;

    

    function setSomeValue(uint _value) external notPaused {
        someValue = _value;
    }
}
