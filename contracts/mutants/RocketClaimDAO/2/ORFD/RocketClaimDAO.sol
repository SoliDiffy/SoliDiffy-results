pragma solidity 0.7.6;

// SPDX-License-Identifier: GPL-3.0-only

import "../../RocketBase.sol";
import "../../../interface/RocketVaultInterface.sol";
import "../../../interface/rewards/RocketRewardsPoolInterface.sol";
import "../../../interface/rewards/claims/RocketClaimDAOInterface.sol";


// RPL Rewards claiming by the DAO
contract RocketClaimDAO is RocketBase, RocketClaimDAOInterface {

    // Events
    event RPLTokensSentByDAOProtocol(string invoiceID, address indexed from, address indexed to, uint256 amount, uint256 time);

    // Construct
    constructor(RocketStorageInterface _rocketStorageAddress) RocketBase(_rocketStorageAddress) {
        // Version
        version = 1;
    }

    // Determine if this contract is enabled or not for claims
    


    // Spend the network DAOs RPL rewards 
    
  

}
