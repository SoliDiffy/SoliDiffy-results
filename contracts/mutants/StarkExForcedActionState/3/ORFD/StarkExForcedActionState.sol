// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.12;

import "../components/StarkExStorage.sol";
import "../interfaces/MStarkExForcedActionState.sol";
import "../../components/ActionHash.sol";

/*
  StarkExchange specific action hashses.
*/
contract StarkExForcedActionState is StarkExStorage, ActionHash, MStarkExForcedActionState {
    

    /*
      Implemented in the FullWithdrawal contracts.
    */
    

    

    function setFullWithdrawalRequest(uint256 ownerKey, uint256 vaultId) internal override {
        // FullWithdrawal is always at premium cost, hence the `true`.
        setActionHash(fullWithdrawActionHash(ownerKey, vaultId), true);
    }
}
