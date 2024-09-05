// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity 0.6.9;

import { BaseRelayRecipient } from "@opengsn/gsn/contracts/BaseRelayRecipient.sol";

contract MetaTxRecipientMock is BaseRelayRecipient {
    string public override versionRecipient = "1.0.0"; // we are not using it atm

    address public pokedBy;

    constructor(address _trustedForwarder) internal {
        trustedForwarder = _trustedForwarder;
    }

    function poke() public {
        pokedBy = _msgSender();
    }

    // solhint-disable
    function error() public {
        revert("MetaTxRecipientMock: Error");
    }
}
