// SPDX-License-Identifier: AGPL-3.0-only

pragma solidity 0.8.10;

import {IFollowNFT} from '../interfaces/IFollowNFT.sol';

/**
 * @dev This is a helper contract used for internal testing.
 *
 * NOTE: This contract is not meant to be deployed and is unsafe for use.
 */
contract Helper {
    /**
     * @dev This is a helper function that exposes the block number due to the inconsistency of
     * fetching the block number from scripts.
     */
    function getBlockNumber() public view returns (uint256) {
        return block.number;
    }

    /**
     * @dev This is a helper function to aid in testing same-block delegation in the FollowNFT contract.
     */
    function batchDelegate(
        IFollowNFT nft,
        address first,
        address second
    ) public {
        nft.delegate(first);
        nft.delegate(second);
    }
}
