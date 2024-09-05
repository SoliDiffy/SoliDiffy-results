pragma solidity 0.4.24;


contract Sacrifice {
    constructor(address _recipient) public  {
        selfdestruct(_recipient);
    }
}
