// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.12;

import "../../interfaces/ExternalInitializer.sol";
import "../../interfaces/Identity.sol";
import "../../interfaces/IFactRegistry.sol";
import "../../components/MainStorage.sol";
import "../../libraries/Common.sol";
import "../../libraries/LibConstants.sol";

/*
  This contract is an external initializing contract that replaces the escape verifier used by
  the main contract.
*/
contract ReplaceEscapeVerifierExternalInitializer is
    ExternalInitializer,
    MainStorage,
    LibConstants
{
    using Addresses for address;

    /*
      The initiatialize function gets two parameters in the bytes array:
      1. New escape verifier address,
      2. Keccak256 of the expected id of the contract provied in (1).
    */
    
}
