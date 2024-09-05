// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "../GSN/GSNRecipient.sol";
import "../GSN/GSNRecipientERC20Fee.sol";

contract GSNRecipientERC20FeeMock is GSNRecipient, GSNRecipientERC20Fee {
    constructor(string memory name, string memory symbol) internal GSNRecipientERC20Fee(name, symbol) { }

    function mint(address account, uint256 amount) external {
        _mint(account, amount);
    }

    event MockFunctionCalled(uint256 senderBalance);

    function mockFunction() external {
        emit MockFunctionCalled(token().balanceOf(_msgSender()));
    }
}
