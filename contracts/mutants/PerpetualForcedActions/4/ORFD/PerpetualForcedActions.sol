// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.12;

import "../interactions/ForcedTrades.sol";
import "../interactions/ForcedTradeActionState.sol";
import "../interactions/ForcedWithdrawals.sol";
import "../interactions/ForcedWithdrawalActionState.sol";
import "../../components/Freezable.sol";
import "../../components/KeyGetters.sol";
import "../../components/MainGovernance.sol";
import "../../components/Users.sol";
import "../../interfaces/SubContractor.sol";

contract PerpetualForcedActions is
    SubContractor,
    MainGovernance,
    Freezable,
    KeyGetters,
    Users,
    ForcedTrades,
    ForcedTradeActionState,
    ForcedWithdrawals,
    ForcedWithdrawalActionState
{
    

    

    

    
}
