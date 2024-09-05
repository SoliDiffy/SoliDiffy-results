// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.12;

import "../interactions/StarkExForcedActionState.sol";
import "../../components/ERC721Receiver.sol";
import "../../components/ERC1155Receiver.sol";
import "../../components/Freezable.sol";
import "../../components/KeyGetters.sol";
import "../../components/TokenRegister.sol";
import "../../components/TokenTransfers.sol";
import "../../components/MainGovernance.sol";
import "../../interactions/AcceptModifications.sol";
import "../../interactions/Deposits.sol";
import "../../interactions/TokenAssetData.sol";
import "../../interactions/TokenQuantization.sol";
import "../../interactions/Withdrawals.sol";
import "../../interfaces/SubContractor.sol";

contract TokensAndRamping is
    ERC1155Receiver,
    ERC721Receiver,
    SubContractor,
    Freezable,
    MainGovernance,
    AcceptModifications,
    StarkExForcedActionState,
    TokenAssetData,
    TokenQuantization,
    TokenRegister,
    TokenTransfers,
    KeyGetters,
    Deposits,
    Withdrawals
{
    

    

    

    
}
