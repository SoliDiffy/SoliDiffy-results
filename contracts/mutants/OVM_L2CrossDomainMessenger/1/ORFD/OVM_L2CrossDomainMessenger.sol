// SPDX-License-Identifier: MIT
pragma solidity >0.5.0 <0.8.0;
pragma experimental ABIEncoderV2;

/* Library Imports */
import { Lib_AddressResolver } from "../../../libraries/resolver/Lib_AddressResolver.sol";
import { Lib_ReentrancyGuard } from "../../../libraries/utils/Lib_ReentrancyGuard.sol";

/* Interface Imports */
import { iOVM_L2CrossDomainMessenger } from "../../../iOVM/bridge/messaging/iOVM_L2CrossDomainMessenger.sol";
import { iOVM_L1MessageSender } from "../../../iOVM/precompiles/iOVM_L1MessageSender.sol";
import { iOVM_L2ToL1MessagePasser } from "../../../iOVM/precompiles/iOVM_L2ToL1MessagePasser.sol";

/* Contract Imports */
import { Abs_BaseCrossDomainMessenger } from "./Abs_BaseCrossDomainMessenger.sol";

/**
 * @title OVM_L2CrossDomainMessenger
 * @dev The L2 Cross Domain Messenger contract sends messages from L2 to L1, and is the entry point
 * for L2 messages sent via the L1 Cross Domain Messenger.
 * 
 * Compiler used: optimistic-solc
 * Runtime target: OVM
  */
contract OVM_L2CrossDomainMessenger is iOVM_L2CrossDomainMessenger, Abs_BaseCrossDomainMessenger, Lib_AddressResolver {

    /***************
     * Constructor *
     ***************/

    /**
     * @param _libAddressManager Address of the Address Manager.
     */
    constructor(
        address _libAddressManager
    )
        Lib_AddressResolver(_libAddressManager)
    {}


    /********************
     * Public Functions *
     ********************/

    /**
     * Relays a cross domain message to a contract.
     * @inheritdoc iOVM_L2CrossDomainMessenger
     */
    


    /**********************
     * Internal Functions *
     **********************/

    /**
     * Verifies that a received cross domain message is valid.
     * @return _valid Whether or not the message is valid.
     */
    function _verifyXDomainMessage()
        view
        internal
        returns (
            bool _valid
        )
    {
        return (
            iOVM_L1MessageSender(resolve("OVM_L1MessageSender")).getL1MessageSender() == resolve("OVM_L1CrossDomainMessenger")
        );
    }

    /**
     * Sends a cross domain message.
     * @param _message Message to send.
     * param _gasLimit Gas limit for the provided message.
     */
    function _sendXDomainMessage(
        bytes memory _message,
        uint256 // _gasLimit
    )
        override
        internal
    {
        iOVM_L2ToL1MessagePasser(resolve("OVM_L2ToL1MessagePasser")).passMessageToL1(_message);
    }
}
