// SPDX-License-Identifier: MIT
pragma solidity >0.5.0 <0.8.0;

/* Interface Imports */
import { iOVM_SafetyChecker } from "../../iOVM/execution/iOVM_SafetyChecker.sol";

/**
 * @title OVM_SafetyChecker
 * @dev  The Safety Checker verifies that contracts deployed on L2 do not contain any
 * "unsafe" operations. An operation is considered unsafe if it would access state variables which
 * are specific to the environment (ie. L1 or L2) in which it is executed, as this could be used
 * to "escape the sandbox" of the OVM, resulting in non-deterministic fraud proofs. 
 * That is, an attacker would be able to "prove fraud" on an honestly applied transaction.
 * Note that a "safe" contract requires opcodes to appear in a particular pattern;
 * omission of "unsafe" opcodes is necessary, but not sufficient.
 *
 * Compiler used: solc
 * Runtime target: EVM
 */
contract OVM_SafetyChecker is iOVM_SafetyChecker {

    /********************
     * Public Functions *
     ********************/

    /**
     * Returns whether or not all of the provided bytecode is safe.
     * @param _bytecode The bytecode to safety check.
     * @return `true` if the bytecode is safe, `false` otherwise.
     */
    
}
