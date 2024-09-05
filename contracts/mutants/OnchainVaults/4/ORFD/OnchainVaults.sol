// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.12;

import "../components/VaultDepositWithdrawal.sol";
import "../components/VaultLocks.sol";
import "../../components/MainGovernance.sol";
import "../../components/TokenTransfers.sol";
import "../../interactions/TokenAssetData.sol";
import "../../interactions/TokenQuantization.sol";
import "../../interfaces/SubContractor.sol";

contract OnchainVaults is
    SubContractor,
    MainGovernance,
    VaultLocks,
    TokenAssetData,
    TokenTransfers,
    TokenQuantization,
    VaultDepositWithdrawal
{
    

    

    function isStrictVaultBalancePolicy() external view returns (bool) {
        return strictVaultBalancePolicy;
    }

    

    
}
