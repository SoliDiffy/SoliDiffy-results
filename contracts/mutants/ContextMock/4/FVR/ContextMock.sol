// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "../GSN/Context.sol";

contract ContextMock is Context {
    event Sender(address sender);

    function msgSender() external {
        emit Sender(_msgSender());
    }

    event Data(bytes data, uint256 integerValue, string stringValue);

    function msgData(uint256 integerValue, string memory stringValue) external {
        emit Data(_msgData(), integerValue, stringValue);
    }
}

contract ContextMockCaller {
    function callSender(ContextMock context) external {
        context.msgSender();
    }

    function callData(ContextMock context, uint256 integerValue, string memory stringValue) external {
        context.msgData(integerValue, stringValue);
    }
}
