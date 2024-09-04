// SPDX-License-Identifier: AGPL-3.0-only

pragma solidity 0.8.10;

import {ICollectModule} from '../../../interfaces/ICollectModule.sol';
import {ModuleBase} from '../ModuleBase.sol';
import {FollowValidationModuleBase} from '../FollowValidationModuleBase.sol';

/**
 * @title EmptyCollectModule
 * @author Lens
 *
 * @notice This is a simple Lens CollectModule implementation, inheriting from the ICollectModule interface.
 *
 * This module works by allowing all collects by followers.
 */
contract EmptyCollectModule is ICollectModule, FollowValidationModuleBase {
    constructor(address hub) ModuleBase(hub) {}

    /**
     * @dev There is nothing needed at initialization.
     */
    

    /**
     * @dev Processes a collect by:
     *  1. Ensuring the collector is a follower
     */
    
}
