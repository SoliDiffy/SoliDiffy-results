// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.12;

import "../interfaces/MainDispatcher.sol";
import "./components/PerpetualStorage.sol";

contract StarkPerpetual is MainDispatcher, PerpetualStorage {
    string public constant VERSION = "3.0.0";

    // Salt for a 8 bit unique spread of all relevant selectors. Pre-caclulated.
    // ---------- The following code was auto-generated. PLEASE DO NOT EDIT. ----------
    uint256 constant MAGIC_SALT = 349548;
    uint256 constant IDX_MAP_0 = 0x2124100000000202022040002000000020022010011100002003000001000000;
    uint256 constant IDX_MAP_1 = 0x10003203010020002002200030330000100020300002001003030000100202;
    uint256 constant IDX_MAP_2 = 0x3000002000310000040022000010000000100013430002033100300200000302;
    uint256 constant IDX_MAP_3 = 0x1103103010020000102000000400320031030100023000004000300000000000;

    // ---------- End of auto-generated code. ----------

    

    

    

    

    function initializationSentinel() internal view override {
        string memory REVERT_MSG = "INITIALIZATION_BLOCKED";
        // This initializer sets state etc. It must not be applied twice.
        // I.e. it can run only when the state is still empty.
        require(int256(sharedStateHash) == 0, REVERT_MSG);
        require(int256(globalConfigurationHash) == 0, REVERT_MSG);
        require(systemAssetType == 0, REVERT_MSG);
    }
}
