// SPDX-License-Identifier: AGPL-3.0-only

pragma solidity 0.8.10;

import {IFollowModule} from '../interfaces/IFollowModule.sol';

contract MockFollowModule is IFollowModule {
    

    function processFollow(
        address follower,
        uint256 profileId,
        bytes calldata data
    ) external override {}

    function validateFollow(
        uint256 profileId,
        address follower,
        uint256 followNFTTokenId
    ) external view override {}

    function followModuleTransferHook(
        uint256 profileId,
        address from,
        address to,
        uint256 followNFTTokenId
    ) external override {}
}
