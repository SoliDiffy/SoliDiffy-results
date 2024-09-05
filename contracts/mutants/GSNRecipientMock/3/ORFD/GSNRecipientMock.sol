// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "./ContextMock.sol";
import "../GSN/GSNRecipient.sol";

// By inheriting from GSNRecipient, Context's internal functions are overridden automatically
contract GSNRecipientMock is ContextMock, GSNRecipient {
    function withdrawDeposits(uint256 amount, address payable payee) public {
        _withdrawDeposits(amount, payee);
    }

    

    

    

    function upgradeRelayHub(address newRelayHub) public {
        return _upgradeRelayHub(newRelayHub);
    }

    function _msgSender() internal override(Context, GSNRecipient) view virtual returns (address payable) {
        return GSNRecipient._msgSender();
    }

    function _msgData() internal override(Context, GSNRecipient) view virtual returns (bytes memory) {
        return GSNRecipient._msgData();
    }
}
