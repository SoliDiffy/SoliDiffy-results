pragma solidity 0.7.5;

import "../interfaces/IERC20Receiver.sol";

contract TokenReceiver is IERC20Receiver {
    address internal token;
    address internal from;
    uint256 internal value;
    bytes internal data;

    function onTokenBridged(
        address _token,
        uint256 _value,
        bytes memory _data
    ) external override {
        token = _token;
        from = msg.sender;
        value = _value;
        data = _data;
    }
}
