pragma solidity ^0.8.0;

contract MockContract {
    address internal lastReceiver;

    function _transfer(address payable _reciver, uint amount) public payable {
        _reciver.transfer(amount);

        lastReceiver = _reciver;
    }
}