// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.12;

import "../components/PerpetualTokenRegister.sol";
import "../../components/TokenTransfers.sol";
import "../../components/ERC721Receiver.sol";
import "../../components/Freezable.sol";
import "../../components/KeyGetters.sol";
import "../../components/UsersV2.sol";
import "../../components/MainGovernance.sol";
import "../../interactions/AcceptModifications.sol";
import "../../interactions/CompositeActionsV2.sol";
import "../../interactions/Deposits.sol";
import "../../interactions/TokenAssetData.sol";
import "../../interactions/TokenQuantization.sol";
import "../../interactions/Withdrawals.sol";
import "../../interfaces/SubContractor.sol";

contract PerpetualTokensAndRampingV2 is
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
    UsersV2,
    Deposits,
    CompositeActionsV2,
    Withdrawals
{
    

    

    

    function identify() external pure override returns (string memory) {
        return "StarkWare_PerpetualTokensAndRampingV2_2022_2";
    }
}
