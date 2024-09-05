// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.12;

import "../../interfaces/ExternalInitializer.sol";
import "../../perpetual/PerpetualConstants.sol";
import "../../perpetual/components/PerpetualStorage.sol";

/*
  This contract is simple impelementation of an external initializing contract
  that configures/reconfigures main contract configuration.
*/
contract UpdatePerpetualConfigExternalInitializer is
    ExternalInitializer,
    PerpetualStorage,
    PerpetualConstants
{
    event LogGlobalConfigurationApplied(bytes32 configHash);
    event LogAssetConfigurationApplied(uint256 assetId, bytes32 configHash);

    
}
