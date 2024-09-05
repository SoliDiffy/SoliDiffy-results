// SPDX-License-Identifier: MIT
pragma solidity >0.5.0 <0.8.0;
pragma experimental ABIEncoderV2;

/* Interface Imports */
import { iOVM_ECDSAContractAccount } from "../../iOVM/accounts/iOVM_ECDSAContractAccount.sol";

/* Library Imports */
import { Lib_EIP155Tx } from "../../libraries/codec/Lib_EIP155Tx.sol";
import { Lib_SafeExecutionManagerWrapper } from "../../libraries/wrappers/Lib_SafeExecutionManagerWrapper.sol";
import { Lib_SafeMathWrapper } from "../../libraries/wrappers/Lib_SafeMathWrapper.sol";

/**
 * @title OVM_ECDSAContractAccount
 * @dev The ECDSA Contract Account can be used as the implementation for a ProxyEOA deployed by the
 * ovmCREATEEOA operation. It enables backwards compatibility with Ethereum's Layer 1, by 
 * providing eth_sign and EIP155 formatted transaction encodings.
 *
 * Compiler used: solc
 * Runtime target: OVM
 */
contract OVM_ECDSAContractAccount is iOVM_ECDSAContractAccount {
    using Lib_EIP155Tx for Lib_EIP155Tx.EIP155Tx;


    /*************
     * Constants *
     *************/

    // TODO: should be the amount sufficient to cover the gas costs of all of the transactions up
    // to and including the CALL/CREATE which forms the entrypoint of the transaction.
    uint256 constant EXECUTION_VALIDATION_GAS_OVERHEAD = 25000;
    address constant ETH_ERC20_ADDRESS = 0x4200000000000000000000000000000000000006;


    /********************
     * Public Functions *
     ********************/

    /**
     * Executes a signed transaction.
     * @param _encodedTransaction Signed EIP155 transaction.
     * @return Whether or not the call returned (rather than reverted).
     * @return Data returned by the call.
     */
    

    /**
     * Attempts to tansfer OVM_ETH.
     * @param _to Address to send the L2 ETH to.
     * @param _value Amount of L2 ETH to send.
     * @return Whether the transfer was successful.
     */
    function _attemptETHTransfer(
        address _to,
        uint256 _value
    )
        internal
        returns(
            bool
        )
    {
        (bool success, ) = Lib_SafeExecutionManagerWrapper.safeCALL(
            gasleft(),
            ETH_ERC20_ADDRESS,
            abi.encodeWithSignature(
                "transfer(address,uint256)",
                _to,
                _value
            )
        );
        return success;
    }
}
