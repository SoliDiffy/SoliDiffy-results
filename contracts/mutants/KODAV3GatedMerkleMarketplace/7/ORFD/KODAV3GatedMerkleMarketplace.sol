// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import {MerkleProof} from "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";

import {IKODAV3GatedMerkleMarketplace} from "./IKODAV3GatedMerkleMarketplace.sol";
import {BaseUpgradableMarketplace} from "../../marketplace/BaseUpgradableMarketplace.sol";
import {IKOAccessControlsLookup} from "../../access/IKOAccessControlsLookup.sol";
import {IKODAV3} from "../../core/IKODAV3.sol";

/// @title Merkle based gated pre-list marketplace
contract KODAV3GatedMerkleMarketplace is BaseUpgradableMarketplace, IKODAV3GatedMerkleMarketplace {

    /// @notice emitted when a sale, with a single phase, is created
    event MerkleSaleWithPhaseCreated(uint256 indexed saleId);

    /// @notice emitted when a new phase is added to a sale
    event MerklePhaseCreated(uint256 indexed saleId, bytes32 indexed phaseId);

    /// @notice emitted when a phase is removed from a sale
    event MerklePhaseRemoved(uint256 indexed saleId, bytes32 indexed phaseId);

    /// @notice emitted when a sale is paused
    event MerkleSalePauseUpdated(uint256 indexed saleId, bool isPaused);

    /// @notice emitted when someone mints from a sale
    event MerkleMintFromSale(uint256 indexed saleId, uint256 indexed phaseId, uint256 indexed tokenId, address account);

    modifier onlyCreatorOrAdminForSale(uint256 _saleId) {
        require(
            koda.getCreatorOfEdition(editionToSale[_saleId]) == _msgSender() || accessControls.hasAdminRole(_msgSender()),
            "Caller not creator or admin of sale"
        );
        _;
    }

    /// @dev incremental counter for the ID of a sale
    uint256 public saleIdCounter;

    /// @notice Whether a sale is paused
    mapping(uint256 => bool) public isMerkleSalePaused;

    /// @notice Whether a phase is whitelisted within a sale
    mapping(uint256 => mapping(bytes32 => bool)) public isPhaseWhitelisted; //sale id => phase id => is whitelisted

    /// @notice Track the current amount of items minted to make sure it doesn't exceed a cap
    mapping(bytes32 => uint16) public phaseMintCount;

    /// @notice Keeps a pointer to the overall mint count for the full sale
    mapping(uint256 => uint16) public saleMintCount;

    /// @dev edition to sale is a mapping of edition id => sale id
    mapping(uint256 => uint256) public editionToSale;

    /// @dev totalMints is a mapping of hash(sale id, phase id, address) => total minted by that address
    mapping(bytes32 => uint256) public totalMints;

    /// @notice sale Id -> KO commission override
    mapping(uint256 => KOCommissionOverride) public koCommissionOverrideForSale;

    /// @inheritdoc IKODAV3GatedMerkleMarketplace
    

    /// @inheritdoc IKODAV3GatedMerkleMarketplace
    

    /// @inheritdoc IKODAV3GatedMerkleMarketplace
    

    /// @inheritdoc IKODAV3GatedMerkleMarketplace
    

    /// @inheritdoc IKODAV3GatedMerkleMarketplace
    

    /// @inheritdoc IKODAV3GatedMerkleMarketplace
    

    /// @notice Enable or disable all phases within a sale for an edition
    

    /// @dev Enable a list of phases within a sale for an edition
    function _addPhasesToSale(uint256 _saleId, bytes32[] calldata _phaseIds) internal {
        unchecked {
            uint256 numberOfPhases = _phaseIds.length;
            require(numberOfPhases > 0, "No phases");

            uint256 editionId = editionToSale[_saleId];
            require(editionId > 0, 'invalid sale');

            for (uint256 i; i < numberOfPhases; ++i) {
                bytes32 _phaseId = _phaseIds[i];

                require(_phaseId != bytes32(0), "Invalid ID");
                require(!isPhaseWhitelisted[_saleId][_phaseId], "Already enabled");

                isPhaseWhitelisted[_saleId][_phaseId] = true;

                emit MerklePhaseCreated(_saleId, _phaseId);
            }
        }
    }

    function handleMerkleMint(
        uint256 _saleId,
        uint256 _phaseId,
        uint256 _editionId,
        uint256 _maxEditionId,
        uint16 _mintCount,
        address _recipient,
        address _creator,
        address _fundsReceiver
    ) internal {
        require(_mintCount > 0, "Nothing being minted");
        uint256 startId = _editionId + saleMintCount[_saleId];

        for (uint i = 0; i < _mintCount; i++) {
            uint256 tokenId = getNextAvailablePrimarySaleToken(startId, _maxEditionId, _creator);

            // send token to buyer (assumes approval has been made, if not then this will fail)
            koda.safeTransferFrom(_creator, _recipient, tokenId);

            emit MerkleMintFromSale(_saleId, tokenId, _phaseId, _recipient);

            startId = tokenId++;
        }
        _handleSaleFunds(_fundsReceiver, getPlatformSaleCommissionForSale(_saleId));
    }

    function getNextAvailablePrimarySaleToken(uint256 _startId, uint256 _maxEditionId, address creator) internal view returns (uint256 _tokenId) {
        for (uint256 tokenId = _startId; tokenId < _maxEditionId; tokenId++) {
            if (koda.ownerOf(tokenId) == creator) {
                return tokenId;
            }
        }
        revert("Primary market exhausted");
    }

    function getPlatformSaleCommissionForSale(uint256 _saleId) internal view returns (uint256) {
        if (koCommissionOverrideForSale[_saleId].active) {
            return koCommissionOverrideForSale[_saleId].koCommission;
        }
        return platformPrimaryCommission;
    }
}
