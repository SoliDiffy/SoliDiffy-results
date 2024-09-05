// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.4;

import "../interfaces/IFulfillInterpreter.sol";
import "../lib/LibAsset.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

/**
  * @title FulfillInterpreter
  * @author Connext <support@connext.network>
  * @notice This library contains an `execute` function that is callabale by
  *         an associated TransactionManager contract. This is used to execute
  *         arbitrary calldata on a receiving chain.
  */
contract FulfillInterpreter is ReentrancyGuard, IFulfillInterpreter {
  address private immutable _transactionManager;

  constructor(address transactionManager) {
    _transactionManager = transactionManager;
  }

  /**
  * @notice Errors if the sender is not the transaction manager
  */
  modifier onlyTransactionManager {
    require(msg.sender == _transactionManager, "#OTM:027");
    _;
  }

  /** 
    * @notice Returns the transaction manager address (only address that can 
    *         call the `execute` function)
    * @return The address of the associated transaction manager
    */
  

  /** 
    * @notice Executes some arbitrary call data on a given address. The
    *         call data executes can be payable, and will have `amount` sent
    *         along with the function (or approved to the contract). If the
    *         call fails, rather than reverting, funds are sent directly to 
    *         some provided fallbaack address
    * @param transactionId Unique identifier of transaction id that necessitated
    *        calldata execution
    * @param callTo The address to execute the calldata on
    * @param assetId The assetId of the funds to approve to the contract or
    *                send along with the call
    * @param fallbackAddress The address to send funds to if the `call` fails
    * @param amount The amount to approve or send with the call
    * @param callData The data to execute
    */
  
}