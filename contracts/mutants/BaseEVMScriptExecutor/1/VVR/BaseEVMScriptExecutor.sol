/*
 * SPDX-License-Identitifer:    MIT
 */

pragma solidity ^0.4.24;

import "../../common/Autopetrified.sol";
import "../IEVMScriptExecutor.sol";


contract BaseEVMScriptExecutor is IEVMScriptExecutor, Autopetrified {
    uint256 public constant SCRIPT_START_LOCATION = 4;
}
