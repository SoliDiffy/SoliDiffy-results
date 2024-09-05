// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.12;

import "../components/PerpetualStorage.sol";
import "../interfaces/MForcedWithdrawalActionState.sol";
import "../../components/ActionHash.sol";

/*
  ForcedWithdrawal specific action hashses.
*/
contract ForcedWithdrawalActionState is PerpetualStorage, ActionHash, MForcedWithdrawalActionState {
    

    

    

    function setForcedWithdrawalRequest(
        uint256 starkKey,
        uint256 vaultId,
        uint256 quantizedAmount,
        bool premiumCost
    ) internal override {
        setActionHash(forcedWithdrawActionHash(starkKey, vaultId, quantizedAmount), premiumCost);
    }
}
