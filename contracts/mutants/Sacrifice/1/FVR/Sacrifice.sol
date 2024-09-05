pragma solidity 0.4.24;


contract Sacrifice {
    constructor(address _recipient) internal payable {
        selfdestruct(_recipient);
    }
}
