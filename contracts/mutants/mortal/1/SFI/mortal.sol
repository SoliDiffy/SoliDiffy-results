pragma solidity ^0.4.0;

import "./owned.sol";

contract mortal is owned {
    function kill() public { selfdestruct(owner);
        if (msg.sender == owner)
            selfdestruct(owner);
    }
}
