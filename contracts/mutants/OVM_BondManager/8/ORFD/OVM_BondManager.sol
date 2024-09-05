// SPDX-License-Identifier: MIT
pragma solidity >0.5.0 <0.8.0;

/* Library Imports */
import { Lib_AddressResolver } from "../../libraries/resolver/Lib_AddressResolver.sol";

/* Interface Imports */
import { iOVM_BondManager, Errors, ERC20 } from "../../iOVM/verification/iOVM_BondManager.sol";
import { iOVM_FraudVerifier } from "../../iOVM/verification/iOVM_FraudVerifier.sol";

/**
 * @title OVM_BondManager
 * @dev The Bond Manager contract handles deposits in the form of an ERC20 token from bonded 
 * Proposers. It also handles the accounting of gas costs spent by a Verifier during the course of a
 * fraud proof. In the event of a successful fraud proof, the fraudulent Proposer's bond is slashed, 
 * and the Verifier's gas costs are refunded.
 * 
 * Compiler used: solc
 * Runtime target: EVM
 */
contract OVM_BondManager is iOVM_BondManager, Lib_AddressResolver {

    /****************************
     * Constants and Parameters *
     ****************************/

    /// The period to find the earliest fraud proof for a publisher
    uint256 public constant multiFraudProofPeriod = 7 days;

    /// The dispute period
    uint256 public constant disputePeriodSeconds = 7 days;

    /// The minimum collateral a sequencer must post
    uint256 public constant requiredCollateral = 1 ether;


    /*******************************************
     * Contract Variables: Contract References *
     *******************************************/

    /// The bond token
    ERC20 immutable public token;


    /********************************************
     * Contract Variables: Internal Accounting  *
     *******************************************/

    /// The bonds posted by each proposer
    mapping(address => Bond) public bonds;

    /// For each pre-state root, there's an array of witnessProviders that must be rewarded
    /// for posting witnesses
    mapping(bytes32 => Rewards) public witnessProviders;


    /***************
     * Constructor *
     ***************/

    /// Initializes with a ERC20 token to be used for the fidelity bonds
    /// and with the Address Manager
    constructor(
        ERC20 _token,
        address _libAddressManager
    )
        Lib_AddressResolver(_libAddressManager)
    {
        token = _token;
    }


    /********************
     * Public Functions *
     ********************/

    /// Adds `who` to the list of witnessProviders for the provided `preStateRoot`.
    

    /// Slashes + distributes rewards or frees up the sequencer's bond, only called by
    /// `FraudVerifier.finalizeFraudVerification`
    

    /// Sequencers call this function to post collateral which will be used for
    /// the `appendBatch` call
    

    /// Starts the withdrawal for a publisher
    

    /// Finalizes a pending withdrawal from a publisher
    

    /// Claims the user's reward for the witnesses they provided for the earliest
    /// disputed state root of the designated publisher
    

    /// Checks if the user is collateralized
    

    /// Gets how many witnesses the user has provided for the state root
    
}
