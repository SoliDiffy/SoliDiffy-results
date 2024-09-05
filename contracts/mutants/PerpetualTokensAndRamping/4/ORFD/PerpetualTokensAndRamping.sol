// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.12;

import "../components/PerpetualTokenRegister.sol";
import "../../components/TokenTransfers.sol";
import "../../components/ERC721Receiver.sol";
import "../../components/Freezable.sol";
import "../../components/KeyGetters.sol";
import "../../components/MainGovernance.sol";
import "../../interactions/AcceptModifications.sol";
import "../../interactions/Deposits.sol";
import "../../interactions/TokenAssetData.sol";
import "../../interactions/TokenQuantization.sol";
import "../../interactions/Withdrawals.sol";
import "../../interfaces/SubContractor.sol";

contract PerpetualTokensAndRamping is
    ERC721Receiver,
    SubContractor,
    Freezable,
    MainGovernance,
    AcceptModifications,
    TokenAssetData,
    TokenQuantization,
    TokenTransfers,
    PerpetualTokenRegister,
    KeyGetters,
    Deposits,
    Withdrawals
{
    

    

    

    
}
