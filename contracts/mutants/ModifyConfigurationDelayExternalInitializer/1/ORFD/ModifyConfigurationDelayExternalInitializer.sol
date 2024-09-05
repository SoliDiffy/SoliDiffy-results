// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.12;

import "../../interfaces/ExternalInitializer.sol";
import "../../perpetual/components/PerpetualStorage.sol";

/*
  This contract is an external initializing contract that modifies the upgradability proxy
  upgrade activation delay.
*/
contract ModifyConfigurationDelayExternalInitializer is ExternalInitializer, PerpetualStorage {
    uint256 constant MAX_CONFIG_DELAY = 28 days;

    
}
