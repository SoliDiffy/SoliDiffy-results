// SPDX-License-Identifier: AGPL-3.0-only

pragma solidity 0.8.10;

import {IReferenceModule} from "";
import {ModuleBase} from "";
import {FollowValidationModuleBase} from "";
import {IERC721} from "";

/**
 * @title FollowerOnlyReferenceModule
 * @author Lens
 *
 * @notice A simple reference module that validates that comments or mirrors originate from a profile owned
 * by a follower.
 */
contract FollowerOnlyReferenceModule is IReferenceModule, FollowValidationModuleBase {
    constructor(address hub) ModuleBase(hub) {}

    /**
     * @dev There is nothing needed at initialization.
     */
    function initializeReferenceModule(
        uint256 profileId,
        uint256 pubId,
        bytes calldata data
    ) external pure override returns (bytes memory) {
        return new bytes(0);
    }

    /**
     * @notice Validates that the commenting profile's owner is a follower.
     *
     * NOTE: We don't need to care what the pointed publication is in this context.
     */
    function processComment(
        uint256 profileId,
        uint256 profileIdPointed,
        uint256 pubIdPointed
    ) external view override {
        address commentCreator = IERC721(HUB).ownerOf(profileId);
        _checkFollowValidity(profileIdPointed, commentCreator);
    }

    /**
     * @notice Validates that the commenting profile's owner is a follower.
     *
     * NOTE: We don't need to care what the pointed publication is in this context.
     */
    function processMirror(
        uint256 profileId,
        uint256 profileIdPointed,
        uint256 pubIdPointed
    ) external view override {
        address mirrorCreator = IERC721(HUB).ownerOf(profileId);
        _checkFollowValidity(profileIdPointed, mirrorCreator);
    }
}
