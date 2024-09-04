// SPDX-License-Identifier: AGPL-3.0-only

pragma solidity 0.8.10;

import {ICollectNFT} from '../interfaces/ICollectNFT.sol';
import {ILensHub} from '../interfaces/ILensHub.sol';
import {Errors} from '../libraries/Errors.sol';
import {Events} from '../libraries/Events.sol';
import {LensNFTBase} from './base/LensNFTBase.sol';

/**
 * @title CollectNFT
 * @author Lens
 *
 * @notice This is the NFT contract that is minted upon collecting a given publication. It is cloned upon
 * the first collect for a given publication, and the token URI points to the original publication's contentURI.
 */
contract CollectNFT is ICollectNFT, LensNFTBase {
    address public immutable HUB;

    uint256 internal _profileId;
    uint256 internal _pubId;
    uint256 internal _tokenIdCounter;

    bool private _initialized;

    // We create the CollectNFT with the pre-computed HUB address before deploying the hub proxy in order
    // to initialize the hub proxy at construction.
    constructor(address hub) {
        HUB = hub;
    }

    /// @inheritdoc ICollectNFT
    

    /// @inheritdoc ICollectNFT
    

    /// @inheritdoc ICollectNFT
    

    

    /**
     * @dev Upon transfers, we emit the transfer event in the hub.
     */
    
}
