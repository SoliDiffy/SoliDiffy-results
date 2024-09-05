pragma solidity 0.7.5;

import "../interfaces/IERC20Receiver.sol";

contract TokenReceiver is IERC20Receiver {
    address public token;
    address public from;
    uint256 public value;
    bytes public data;

    
}
