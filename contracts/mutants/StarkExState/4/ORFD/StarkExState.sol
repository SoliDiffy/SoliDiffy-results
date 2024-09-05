// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.12;

import "../components/Escapes.sol";
import "../interactions/StarkExForcedActionState.sol";
import "../interactions/UpdateState.sol";
import "../../components/Freezable.sol";
import "../../components/MainGovernance.sol";
import "../../components/StarkExOperator.sol";
import "../../interactions/AcceptModifications.sol";
import "../../interactions/StateRoot.sol";
import "../../interactions/TokenQuantization.sol";
import "../../interfaces/SubContractor.sol";

contract StarkExState is
    MainGovernance,
    SubContractor,
    StarkExOperator,
    Freezable,
    AcceptModifications,
    TokenQuantization,
    StarkExForcedActionState,
    StateRoot,
    Escapes,
    UpdateState
{
    // InitializationArgStruct contains 2 * address + 8 * uint256 + 1 * bool = 352 bytes.
    uint256 constant INITIALIZER_SIZE = 11 * 32;

    struct InitializationArgStruct {
        uint256 globalConfigCode;
        address escapeVerifierAddress;
        uint256 sequenceNumber;
        uint256 validiumVaultRoot;
        uint256 rollupVaultRoot;
        uint256 orderRoot;
        uint256 validiumTreeHeight;
        uint256 rollupTreeHeight;
        uint256 orderTreeHeight;
        bool strictVaultBalancePolicy;
        address orderRegistryAddress;
    }

    /*
      Initialization flow:
      1. Extract initialization parameters from data.
      2. Call internalInitializer with those parameters.
    */
    

    /*
      The call to initializerSize is done from MainDispatcherBase using delegatecall,
      thus the existing state is already accessible.
    */
    

    

    
}
