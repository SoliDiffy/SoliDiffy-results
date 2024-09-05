// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "../GSN/GSNRecipient.sol";
import "../GSN/GSNRecipientSignature.sol";

contract GSNRecipientSignatureMock is GSNRecipient, GSNRecipientSignature {
    

    event MockFunctionCalled();

    function mockFunction() public {
        emit MockFunctionCalled();
    }
}
