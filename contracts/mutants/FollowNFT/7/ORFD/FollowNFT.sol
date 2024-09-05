// SPDX-License-Identifier: AGPL-3.0-only

pragma solidity 0.8.10;

import {IFollowNFT} from '../interfaces/IFollowNFT.sol';
import {IFollowModule} from '../interfaces/IFollowModule.sol';
import {ILensHub} from '../interfaces/ILensHub.sol';
import {Errors} from '../libraries/Errors.sol';
import {Events} from '../libraries/Events.sol';
import {DataTypes} from '../libraries/DataTypes.sol';
import {LensNFTBase} from './base/LensNFTBase.sol';
import {IERC721Metadata} from '@openzeppelin/contracts/token/ERC721/extensions/IERC721Metadata.sol';

/**
 * @title FollowNFT
 * @author Lens
 *
 * @notice This contract is the NFT that is minted upon following a given profile. It is cloned upon first follow for a
 * given profile, and includes built-in governance power and delegation mechanisms.
 */
contract FollowNFT is LensNFTBase, IFollowNFT {
    struct Snapshot {
        uint128 blockNumber;
        uint128 value;
    }

    address public immutable HUB;

    bytes32 internal constant DELEGATE_BY_SIG_TYPEHASH =
        0xb8f190a57772800093f4e2b186099eb4f1df0ed7f5e2791e89a4a07678e0aeff;
    // keccak256(
    // 'DelegateBySig(address delegator,address delegatee,uint256 nonce,uint256 deadline)'
    // );

    mapping(address => mapping(uint256 => Snapshot)) internal _snapshots;
    mapping(address => address) internal _delegates;
    mapping(address => uint256) internal _snapshotCount;
    uint256 internal _profileId;
    uint256 internal _tokenIdCounter;

    bool private _initialized;

    // We create the FollowNFT with the pre-computed HUB address before deploying the hub.
    constructor(address hub) {
        HUB = hub;
    }

    /// @inheritdoc IFollowNFT
    

    /// @inheritdoc IFollowNFT
    

    /// @inheritdoc IFollowNFT
    

    /// @inheritdoc IFollowNFT
    

    /// @inheritdoc IFollowNFT
    

    

    /**
     * @dev Upon transfers, we move the appropriate delegations, and emit the transfer event in the hub.
     */
    

    function _delegate(address delegator, address delegatee) internal {
        uint256 delegatorBalance = balanceOf(delegator);
        address previousDelegate = _delegates[delegator];
        _delegates[delegator] = delegatee;
        _moveDelegate(previousDelegate, delegatee, delegatorBalance);
    }

    function _moveDelegate(
        address from,
        address to,
        uint256 amount
    ) internal {
        // NOTE: Since we start with no delegate, this condition is only fulfilled if a delegation occurred
        if (from != address(0)) {
            uint256 previous = 0;
            uint256 fromSnapshotCount = _snapshotCount[from];

            previous = _snapshots[from][fromSnapshotCount - 1].value;

            _writeSnapshot(from, uint128(previous - amount), fromSnapshotCount);
            emit Events.FollowNFTDelegatedPowerChanged(from, previous - amount, block.timestamp);
        }

        if (to != address(0)) {
            uint256 previous = 0;
            uint256 toSnapshotCount = _snapshotCount[to];

            if (toSnapshotCount != 0) {
                previous = _snapshots[to][toSnapshotCount - 1].value;
            }
            _writeSnapshot(to, uint128(previous + amount), toSnapshotCount);
            emit Events.FollowNFTDelegatedPowerChanged(to, previous + amount, block.timestamp);
        }
    }

    // Passing the snapshot count to prevent reading from storage to fetch it again in case of multiple operations
    function _writeSnapshot(
        address owner,
        uint128 newValue,
        uint256 ownerSnapshotCount
    ) internal {
        uint128 currentBlock = uint128(block.number);
        mapping(uint256 => Snapshot) storage ownerSnapshots = _snapshots[owner];

        // Doing multiple operations in the same block
        if (
            ownerSnapshotCount != 0 &&
            ownerSnapshots[ownerSnapshotCount - 1].blockNumber == currentBlock
        ) {
            ownerSnapshots[ownerSnapshotCount - 1].value = newValue;
        } else {
            ownerSnapshots[ownerSnapshotCount] = Snapshot(currentBlock, newValue);
            _snapshotCount[owner] = ownerSnapshotCount + 1;
        }
    }
}
