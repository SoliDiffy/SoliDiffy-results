// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.12;

import "../interactions/FullWithdrawals.sol";
import "../interactions/StarkExForcedActionState.sol";
import "../../components/Freezable.sol";
import "../../components/KeyGetters.sol";
import "../../components/MainGovernance.sol";
import "../../components/Users.sol";
import "../../interfaces/SubContractor.sol";

contract ForcedActions is
    SubContractor,
    MainGovernance,
    Freezable,
    KeyGetters,
    Users,
    FullWithdrawals,
    StarkExForcedActionState
{
    

    

    

    function identify() external pure override returns (string memory) {
        return "StarkWare_ForcedActions_2022_2";
    }
}
