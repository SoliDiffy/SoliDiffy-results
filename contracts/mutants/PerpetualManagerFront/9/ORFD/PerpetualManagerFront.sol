// SPDX-License-Identifier: GNU GPLv3

pragma solidity ^0.8.7;

import "./PerpetualManager.sol";

/// @title PerpetualManagerFront
/// @author Angle Core Team
/// @notice `PerpetualManager` is the contract handling all the Hedging Agents perpetuals
/// @dev There is one `PerpetualManager` contract per pair stablecoin/collateral in the protocol
/// @dev This file contains the functions of the `PerpetualManager` that can be directly interacted
/// with by external agents. These functions are the ones that need to be called to open, modify or close
/// perpetuals
/// @dev `PerpetualManager` naturally handles staking, the code allowing HAs to stake has been inspired from
/// https://github.com/SetProtocol/index-coop-contracts/blob/master/contracts/staking/StakingRewardsV2.sol
/// @dev Perpetuals at Angle protocol are treated as NFTs, this contract handles the logic for that
contract PerpetualManagerFront is PerpetualManager, IPerpetualManagerFront {
    using SafeERC20 for IERC20;
    using CountersUpgradeable for CountersUpgradeable.Counter;

    // =============================== Deployer ====================================

    /// @notice Initializes the `PerpetualManager` contract
    /// @param poolManager_ Reference to the `PoolManager` contract handling the collateral associated to the `PerpetualManager`
    /// @param rewardToken_ Reference to the `rewardtoken` that can be distributed to HAs as they have open positions
    /// @dev The reward token is most likely going to be the ANGLE token
    /// @dev Since this contract is upgradeable, this function is an `initialize` and not a `constructor`
    /// @dev Zero checks are only performed on addresses for which no external calls are made, in this case just
    /// the `rewardToken_` is checked
    /// @dev After initializing this contract, all the fee parameters should be initialized by governance using
    /// the setters in this contract
    function initialize(IPoolManager poolManager_, IERC20 rewardToken_)
        external
        initializer
        zeroCheck(address(rewardToken_))
    {
        // Initializing contracts
        __Pausable_init();
        __AccessControl_init();

        // Creating references
        poolManager = poolManager_;
        _token = IERC20(poolManager_.token());
        _stableMaster = IStableMaster(poolManager_.stableMaster());
        rewardToken = rewardToken_;
        _collatBase = 10**(IERC20Metadata(address(_token)).decimals());
        // The references to the `feeManager` and to the `oracle` contracts are to be set when the contract is deployed

        // Setting up Access Control for this contract
        // There is no need to store the reference to the `PoolManager` address here
        // Once the `POOLMANAGER_ROLE` has been granted, no new addresses can be granted or revoked
        // from this role: a `PerpetualManager` contract can only have one `PoolManager` associated
        _setupRole(POOLMANAGER_ROLE, address(poolManager));
        // `PoolManager` is admin of all the roles. Most of the time, changes are propagated from it
        _setRoleAdmin(GUARDIAN_ROLE, POOLMANAGER_ROLE);
        _setRoleAdmin(POOLMANAGER_ROLE, POOLMANAGER_ROLE);
        // Pausing the contract because it is not functional till the collateral has really been deployed by the
        // `StableMaster`
        _pause();
    }

    // ================================= HAs =======================================

    /// @notice Lets a HA join the protocol and create a perpetual
    /// @param owner Address of the future owner of the perpetual
    /// @param margin Amount of collateral brought by the HA
    /// @param committedAmount Amount of collateral covered by the HA
    /// @param maxOracleRate Maximum oracle value that the HA wants to see stored in the perpetual
    /// @param minNetMargin Minimum net margin that the HA is willing to see stored in the perpetual
    /// @return perpetualID The ID of the perpetual opened by this HA
    /// @dev The future owner of the perpetual cannot be the zero address
    /// @dev It is possible to open a perpetual on behalf of someone else
    /// @dev The `maxOracleRate` parameter serves as a protection against oracle manipulations for HAs opening perpetuals
    /// @dev `minNetMargin` is a protection against too big variations in the fees for HAs
    

    /// @notice Lets a HA close a perpetual owned or controlled for the stablecoin/collateral pair associated
    /// to this `PerpetualManager` contract
    /// @param perpetualID ID of the perpetual to close
    /// @param to Address which will receive the proceeds from this perpetual
    /// @param minCashOutAmount Minimum net cash out amount that the HA is willing to get for closing the
    /// perpetual
    /// @dev The HA gets the current amount of her position depending on the entry oracle value
    /// and current oracle value minus some transaction fees computed on the committed amount
    /// @dev `msg.sender` should be the owner of `perpetualID` or be approved for this perpetual
    /// @dev If the `PoolManager` does not have enough collateral, the perpetual owner will be converted to a SLP and
    /// receive sanTokens
    /// @dev The `minCashOutAmount` serves as a protection for HAs closing their perpetuals: it protects them both
    /// from fees that would have become too high and from a too big decrease in oracle value
    

    /// @notice Lets a HA increase the `margin` in a perpetual she controls for this
    /// stablecoin/collateral pair
    /// @param perpetualID ID of the perpetual to which amount should be added to `margin`
    /// @param amount Amount to add to the perpetual's `margin`
    /// @dev This decreases the leverage multiple of this perpetual
    /// @dev If this perpetual is to be liquidated, the HA is not going to be able to add liquidity to it
    /// @dev Since this function can be used to add liquidity to a perpetual, there is no need to restrict
    /// it to the owner of the perpetual
    /// @dev Calling this function on a non-existing perpetual makes it revert
    

    /// @notice Lets a HA decrease the `margin` in a perpetual she controls for this
    /// stablecoin/collateral pair
    /// @param perpetualID ID of the perpetual from which collateral should be removed
    /// @param amount Amount to remove from the perpetual's `margin`
    /// @param to Address which will receive the collateral removed from this perpetual
    /// @dev This increases the leverage multiple of this perpetual
    /// @dev `msg.sender` should be the owner of `perpetualID` or be approved for this perpetual
    

    /// @notice Allows an outside caller to liquidate perpetuals if their margin ratio is
    /// under the maintenance margin
    /// @param perpetualIDs ID of the targeted perpetuals
    /// @dev Liquidation of a perpetual will succeed if the `cashOutAmount` of the perpetual is under the maintenance margin,
    /// and nothing will happen if the perpetual is still healthy
    /// @dev The outside caller (namely a keeper) gets a portion of the leftover cash out amount of the perpetual
    /// @dev As keepers may directly profit from this function, there may be front-running problems with miners bots,
    /// we may have to put an access control logic for this function to only allow white-listed addresses to act
    /// as keepers for the protocol
    

    /// @notice Allows an outside caller to close perpetuals if too much of the collateral from
    /// users is hedged by HAs
    /// @param perpetualIDs IDs of the targeted perpetuals
    /// @dev This function allows to make sure that the protocol will not have too much HAs for a long period of time
    /// @dev A HA that owns a targeted perpetual will get the current value of her perpetual
    /// @dev The call to the function above will revert if HAs cannot be cashed out
    /// @dev As keepers may directly profit from this function, there may be front-running problems with miners bots,
    /// we may have to put an access control logic for this function to only allow white-listed addresses to act
    /// as keepers for the protocol
    

    // =========================== External View Function ==========================

    /// @notice Returns the `cashOutAmount` of the perpetual owned by someone at a given oracle value
    /// @param perpetualID ID of the perpetual
    /// @param rate Oracle value
    /// @return The `cashOutAmount` of the perpetual
    /// @return Whether the position of the perpetual is now too small compared with its initial position and should hence
    /// be liquidated
    /// @dev This function is used by the Collateral Settlement contract
    

    // =========================== Reward Distribution =============================

    /// @notice Allows to check the amount of reward tokens earned by a perpetual
    /// @param perpetualID ID of the perpetual to check
    function earned(uint256 perpetualID) external view returns (uint256) {
        return _earned(perpetualID, perpetualData[perpetualID].committedAmount * perpetualData[perpetualID].entryRate);
    }

    /// @notice Allows a perpetual owner to withdraw rewards
    /// @param perpetualID ID of the perpetual which accumulated tokens
    /// @dev Only an approved caller can claim the rewards for the perpetual with perpetualID
    function getReward(uint256 perpetualID) external whenNotPaused onlyApprovedOrOwner(msg.sender, perpetualID) {
        _getReward(perpetualID, perpetualData[perpetualID].committedAmount * perpetualData[perpetualID].entryRate);
    }

    // =============================== ERC721 logic ================================

    /// @notice Gets the name of the NFT collection implemented by this contract
    

    /// @notice Gets the symbol of the NFT collection implemented by this contract
    

    /// @notice Gets the URI containing metadata
    /// @param perpetualID ID of the perpetual
    function tokenURI(uint256 perpetualID) external view override returns (string memory) {
        require(_exists(perpetualID), "2");
        // There is no perpetual with `perpetualID` equal to 0, so the following variable is
        // always greater than zero
        uint256 temp = perpetualID;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        while (perpetualID != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(perpetualID % 10)));
            perpetualID /= 10;
        }
        return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI, string(buffer))) : "";
    }

    /// @notice Gets the balance of an owner
    /// @param owner Address of the owner
    /// @dev Balance here represents the number of perpetuals owned by a HA
    function balanceOf(address owner) external view override returns (uint256) {
        require(owner != address(0), "0");
        return _balances[owner];
    }

    /// @notice Gets the owner of the perpetual with ID perpetualID
    /// @param perpetualID ID of the perpetual
    function ownerOf(uint256 perpetualID) external view override returns (address) {
        return _ownerOf(perpetualID);
    }

    /// @notice Approves to an address specified by `to` a perpetual specified by `perpetualID`
    /// @param to Address to approve the perpetual to
    /// @param perpetualID ID of the perpetual
    /// @dev The approved address will have the right to transfer the perpetual, to cash it out
    /// on behalf of the owner, to add or remove collateral in it and to choose the destination
    /// address that will be able to receive the proceeds of the perpetual
    function approve(address to, uint256 perpetualID) external override {
        address owner = _ownerOf(perpetualID);
        require(to != owner, "35");
        require(msg.sender == owner || isApprovedForAll(owner, msg.sender), "21");

        _approve(to, perpetualID);
    }

    /// @notice Gets the approved address by a perpetual owner
    /// @param perpetualID ID of the concerned perpetual
    function getApproved(uint256 perpetualID) external view override returns (address) {
        require(_exists(perpetualID), "2");
        return _getApproved(perpetualID);
    }

    /// @notice Sets approval on all perpetuals owned by the owner to an operator
    /// @param operator Address to approve (or block) on all perpetuals
    /// @param approved Whether the sender wants to approve or block the operator
    function setApprovalForAll(address operator, bool approved) external override {
        require(operator != msg.sender, "36");
        _operatorApprovals[msg.sender][operator] = approved;
        emit ApprovalForAll(_msgSender(), operator, approved);
    }

    /// @notice Gets if the operator address is approved on all perpetuals by the owner
    /// @param owner Owner of perpetuals
    /// @param operator Address to check if approved
    function isApprovedForAll(address owner, address operator) public view override returns (bool) {
        return _operatorApprovals[owner][operator];
    }

    /// @notice Gets if the sender address is approved for the perpetualId
    /// @param perpetualID ID of the perpetual
    function isApprovedOrOwner(address spender, uint256 perpetualID) external view override returns (bool) {
        return _isApprovedOrOwner(spender, perpetualID);
    }

    /// @notice Transfers the `perpetualID` from an address to another
    /// @param from Source address
    /// @param to Destination a address
    /// @param perpetualID ID of the perpetual to transfer
    function transferFrom(
        address from,
        address to,
        uint256 perpetualID
    ) external override onlyApprovedOrOwner(msg.sender, perpetualID) {
        _transfer(from, to, perpetualID);
    }

    /// @notice Safely transfers the `perpetualID` from an address to another without data in it
    /// @param from Source address
    /// @param to Destination a address
    /// @param perpetualID ID of the perpetual to transfer
    function safeTransferFrom(
        address from,
        address to,
        uint256 perpetualID
    ) external override {
        safeTransferFrom(from, to, perpetualID, "");
    }

    /// @notice Safely transfers the `perpetualID` from an address to another with data in the transfer
    /// @param from Source address
    /// @param to Destination a address
    /// @param perpetualID ID of the perpetual to transfer
    function safeTransferFrom(
        address from,
        address to,
        uint256 perpetualID,
        bytes memory _data
    ) public override onlyApprovedOrOwner(msg.sender, perpetualID) {
        _safeTransfer(from, to, perpetualID, _data);
    }

    // =============================== ERC165 logic ================================

    /// @notice Queries if a contract implements an interface
    /// @param interfaceId The interface identifier, as specified in ERC-165
    /// @dev Interface identification is specified in ERC-165. This function uses less than 30,000 gas.
    /// Required by the ERC721 standard, so used to check that the IERC721 is implemented.
    /// @return `true` if the contract implements `interfaceID` and
    ///  `interfaceID` is not 0xffffffff, `false` otherwise
    function supportsInterface(bytes4 interfaceId) external pure override(IERC165) returns (bool) {
        return
            interfaceId == type(IPerpetualManagerFront).interfaceId ||
            interfaceId == type(IPerpetualManagerFunctions).interfaceId ||
            interfaceId == type(IStakingRewards).interfaceId ||
            interfaceId == type(IStakingRewardsFunctions).interfaceId ||
            interfaceId == type(IAccessControl).interfaceId ||
            interfaceId == type(IERC721Metadata).interfaceId ||
            interfaceId == type(IERC721).interfaceId ||
            interfaceId == type(IERC165).interfaceId;
    }
}
