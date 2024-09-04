// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity 0.6.9;

contract AMBBridgeMock {
    address msgSender;
    bytes32 msgId;

    function mockSetMessageId(bytes32 _msgId) public {
        msgId = _msgId;
    }

    function mockSetMessageSender(address _addr) public {
        msgSender = _addr;
    }

    function messageSender() public view returns (address) {
        return msgSender;
    }

    // 1st parameter will execute the data of 2nd parameter directly
    // in that way, we could verify our function should be called correctly on the other side.
    function requireToPassMessage(
        address _contract,
        bytes calldata _data,
        uint256 _gas
    ) public returns (bytes32) {
        (bool ret, bytes memory _) = _contract.call(_data);
        if (!ret) {
            revert("execute error");
        }
        return msgId;
    }

    function messageId() public view returns (bytes32) {
        return msgId;
    }
}
