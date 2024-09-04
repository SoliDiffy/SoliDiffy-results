// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

contract EtherReceiverMock {
    bool public _acceptEther;

    function setAcceptEther(bool acceptEther) public {
        _acceptEther = acceptEther;
    }

    receive () external payable {
        if (!_acceptEther) {
            revert();
        }
    }
}
