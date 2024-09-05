// SPDX-License-Identifier: MIT
// @unsupported: ovm
pragma solidity >0.5.0 <0.8.0;
pragma experimental ABIEncoderV2;

/* Library Imports */
import { Lib_OVMCodec } from "../../libraries/codec/Lib_OVMCodec.sol";
import { Lib_AddressResolver } from "../../libraries/resolver/Lib_AddressResolver.sol";
import { Lib_EthUtils } from "../../libraries/utils/Lib_EthUtils.sol";
import { Lib_Bytes32Utils } from "../../libraries/utils/Lib_Bytes32Utils.sol";
import { Lib_BytesUtils } from "../../libraries/utils/Lib_BytesUtils.sol";
import { Lib_SecureMerkleTrie } from "../../libraries/trie/Lib_SecureMerkleTrie.sol";
import { Lib_RLPWriter } from "../../libraries/rlp/Lib_RLPWriter.sol";
import { Lib_RLPReader } from "../../libraries/rlp/Lib_RLPReader.sol";

/* Interface Imports */
import { iOVM_StateTransitioner } from "../../iOVM/verification/iOVM_StateTransitioner.sol";
import { iOVM_BondManager } from "../../iOVM/verification/iOVM_BondManager.sol";
import { iOVM_ExecutionManager } from "../../iOVM/execution/iOVM_ExecutionManager.sol";
import { iOVM_StateManager } from "../../iOVM/execution/iOVM_StateManager.sol";
import { iOVM_StateManagerFactory } from "../../iOVM/execution/iOVM_StateManagerFactory.sol";

/* Contract Imports */
import { Abs_FraudContributor } from "./Abs_FraudContributor.sol";

/**
 * @title OVM_StateTransitioner
 * @dev The State Transitioner coordinates the execution of a state transition during the evaluation of a
 * fraud proof. It feeds verified input to the Execution Manager's run(), and controls a State Manager (which is
 * uniquely created for each fraud proof).
 * Once a fraud proof has been initialized, this contract is provided with the pre-state root and verifies
 * that the OVM storage slots committed to the State Mangager are contained in that state
 * This contract controls the State Manager and Execution Manager, and uses them to calculate the
 * post-state root by applying the transaction. The Fraud Verifier can then check for fraud by comparing
 * the calculated post-state root with the proposed post-state root.
 * 
 * Compiler used: solc
 * Runtime target: EVM
 */
contract OVM_StateTransitioner is Lib_AddressResolver, Abs_FraudContributor, iOVM_StateTransitioner {

    /*******************
     * Data Structures *
     *******************/

    enum TransitionPhase {
        PRE_EXECUTION,
        POST_EXECUTION,
        COMPLETE
    }


    /*******************************************
     * Contract Variables: Contract References *
     *******************************************/

    iOVM_StateManager public ovmStateManager;


    /*******************************************
     * Contract Variables: Internal Accounting *
     *******************************************/

    bytes32 internal preStateRoot;
    bytes32 internal postStateRoot;
    TransitionPhase public phase;
    uint256 internal stateTransitionIndex;
    bytes32 internal transactionHash;


    /*************
     * Constants *
     *************/

    bytes32 internal constant EMPTY_ACCOUNT_CODE_HASH = 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470;
    bytes32 internal constant EMPTY_ACCOUNT_STORAGE_ROOT = 0x56e81f171bcc55a6ff8345e692c0f86e5b48e01b996cadc001622fb5e363b421;


    /***************
     * Constructor *
     ***************/

    /**
     * @param _libAddressManager Address of the Address Manager.
     * @param _stateTransitionIndex Index of the state transition being verified.
     * @param _preStateRoot State root before the transition was executed.
     * @param _transactionHash Hash of the executed transaction.
     */
    constructor(
        address _libAddressManager,
        uint256 _stateTransitionIndex,
        bytes32 _preStateRoot,
        bytes32 _transactionHash
    )
        Lib_AddressResolver(_libAddressManager)
    {
        stateTransitionIndex = _stateTransitionIndex;
        preStateRoot = _preStateRoot;
        postStateRoot = _preStateRoot;
        transactionHash = _transactionHash;

        ovmStateManager = iOVM_StateManagerFactory(resolve("OVM_StateManagerFactory")).create(address(this));
    }


    /**********************
     * Function Modifiers *
     **********************/

    /**
     * Checks that a function is only run during a specific phase.
     * @param _phase Phase the function must run within.
     */
    modifier onlyDuringPhase(
        TransitionPhase _phase
    ) {
        require(
            phase == _phase,
            "Function must be called during the correct phase."
        );
        _;
    }


    /**********************************
     * Public Functions: State Access *
     **********************************/

    /**
     * Retrieves the state root before execution.
     * @return _preStateRoot State root before execution.
     */
    

    /**
     * Retrieves the state root after execution.
     * @return _postStateRoot State root after execution.
     */
    

    /**
     * Checks whether the transitioner is complete.
     * @return _complete Whether or not the transition process is finished.
     */
    
    

    /***********************************
     * Public Functions: Pre-Execution *
     ***********************************/

    /**
     * Allows a user to prove the initial state of a contract.
     * @param _ovmContractAddress Address of the contract on the OVM.
     * @param _ethContractAddress Address of the corresponding contract on L1.
     * @param _stateTrieWitness Proof of the account state.
     */
    

    /**
     * Allows a user to prove the initial state of a contract storage slot.
     * @param _ovmContractAddress Address of the contract on the OVM.
     * @param _key Claimed account slot key.
     * @param _storageTrieWitness Proof of the storage slot.
     */
    


    /*******************************
     * Public Functions: Execution *
     *******************************/

    /**
     * Executes the state transition.
     * @param _transaction OVM transaction to execute.
     */
    


    /************************************
     * Public Functions: Post-Execution *
     ************************************/

    /**
     * Allows a user to commit the final state of a contract.
     * @param _ovmContractAddress Address of the contract on the OVM.
     * @param _stateTrieWitness Proof of the account state.
     */
    

    /**
     * Allows a user to commit the final state of a contract storage slot.
     * @param _ovmContractAddress Address of the contract on the OVM.
     * @param _key Claimed account slot key.
     * @param _storageTrieWitness Proof of the storage slot.
     */
    


    /**********************************
     * Public Functions: Finalization *
     **********************************/

    /**
     * Finalizes the transition process.
     */
    
}
