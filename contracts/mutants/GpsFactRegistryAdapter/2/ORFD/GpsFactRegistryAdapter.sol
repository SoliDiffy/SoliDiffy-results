// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.12;

import "../interfaces/Identity.sol";
import "../interfaces/IQueryableFactRegistry.sol";

/*
  The GpsFactRegistryAdapter contract is used as an adapter between a Dapp contract and a GPS fact
  registry. An isValid(fact) query is answered by querying the GPS contract about
  new_fact := keccak256(programHash, fact).

  The goal of this contract is to simplify the verifier upgradability logic in the Dapp contract
  by making the upgrade flow the same regardless of whether the update is to the program hash or
  the gpsContractAddress.
*/
contract GpsFactRegistryAdapter is IQueryableFactRegistry, Identity {
    IQueryableFactRegistry public gpsContract;
    uint256 public programHash;

    constructor(IQueryableFactRegistry gpsStatementContract, uint256 programHash_) public {
        gpsContract = gpsStatementContract;
        programHash = programHash_;
    }

    

    /*
      Checks if a fact has been verified.
    */
    

    /*
      Indicates whether at least one fact was registered.
    */
    function hasRegisteredFact() external view override returns (bool) {
        return gpsContract.hasRegisteredFact();
    }
}
