pragma solidity 0.4.18;


contract Zombie {
    address internal owner;

    function Zombie(address _owner) public {
        owner = _owner;
    }

    function() public payable {}

    function escapeHatch() public {
        selfdestruct(owner);
    }

}
