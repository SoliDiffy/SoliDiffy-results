// SPDX-License-Identifier: agpl-3.0
pragma solidity ^0.8.0;

/**
 * @title OUSD Aave Strategy
 * @notice Investment strategy for investing stablecoins via Aave
 * @author Origin Protocol Inc
 */
import { SafeERC20 } from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

import "./IAave.sol";
import { IERC20, InitializableAbstractStrategy } from "../utils/InitializableAbstractStrategy.sol";

import { IAaveStakedToken } from "./IAaveStakeToken.sol";
import { IAaveIncentivesController } from "./IAaveIncentivesController.sol";

contract AaveStrategy is InitializableAbstractStrategy {
    using SafeERC20 for IERC20;

    uint16 constant referralCode = 92;

    IAaveIncentivesController public incentivesController;
    IAaveStakedToken public stkAave;

    /**
     * Initializer for setting up strategy internal state. This overrides the
     * InitializableAbstractStrategy initializer as AAVE needs several extra
     * addresses for the rewards program.
     * @param _platformAddress Address of the AAVE pool
     * @param _vaultAddress Address of the vault
     * @param _rewardTokenAddresses Address of the AAVE token
     * @param _assets Addresses of supported assets
     * @param _pTokens Platform Token corresponding addresses
     * @param _incentivesAddress Address of the AAVE incentives controller
     * @param _stkAaveAddress Address of the stkAave contract
     */
    function initialize(
        address _platformAddress, // AAVE pool
        address _vaultAddress,
        address[] calldata _rewardTokenAddresses, // AAVE
        address[] calldata _assets,
        address[] calldata _pTokens,
        address _incentivesAddress,
        address _stkAaveAddress
    ) external onlyGovernor initializer {
        incentivesController = IAaveIncentivesController(_incentivesAddress);
        stkAave = IAaveStakedToken(_stkAaveAddress);
        InitializableAbstractStrategy._initialize(
            _platformAddress,
            _vaultAddress,
            _rewardTokenAddresses,
            _assets,
            _pTokens
        );
    }

    /**
     * @dev Deposit asset into Aave
     * @param _asset Address of asset to deposit
     * @param _amount Amount of asset to deposit
     */
    

    /**
     * @dev Deposit asset into Aave
     * @param _asset Address of asset to deposit
     * @param _amount Amount of asset to deposit
     */
    function _deposit(address _asset, uint256 _amount) internal {
        require(_amount > 0, "Must deposit something");
        // Following line also doubles as a check that we are depositing
        // an asset that we support.
        emit Deposit(_asset, _getATokenFor(_asset), _amount);
        _getLendingPool().deposit(_asset, _amount, address(this), referralCode);
    }

    /**
     * @dev Deposit the entire balance of any supported asset into Aave
     */
    

    /**
     * @dev Withdraw asset from Aave
     * @param _recipient Address to receive withdrawn asset
     * @param _asset Address of asset to withdraw
     * @param _amount Amount of asset to withdraw
     */
    

    /**
     * @dev Remove all assets from platform and send them to Vault contract.
     */
    

    /**
     * @dev Get the total asset value held in the platform
     * @param _asset      Address of the asset
     * @return balance    Total value of the asset in the platform
     */
    

    /**
     * @dev Returns bool indicating whether asset is supported by strategy
     * @param _asset Address of the asset
     */
    

    /**
     * @dev Approve the spending of all assets by their corresponding aToken,
     *      if for some reason is it necessary.
     */
    

    /**
     * @dev Internal method to respond to the addition of new asset / aTokens
            We need to give the AAVE lending pool approval to transfer the
            asset.
     * @param _asset Address of the asset to approve
     * @param _aToken Address of the aToken
     */
    

    /**
     * @dev Get the aToken wrapped in the IERC20 interface for this asset.
     *      Fails if the pToken doesn't exist in our mappings.
     * @param _asset Address of the asset
     * @return Corresponding aToken to this asset
     */
    function _getATokenFor(address _asset) internal view returns (address) {
        address aToken = assetToPToken[_asset];
        require(aToken != address(0), "aToken does not exist");
        return aToken;
    }

    /**
     * @dev Get the current address of the Aave lending pool, which is the gateway to
     *      depositing.
     * @return Current lending pool implementation
     */
    function _getLendingPool() internal view returns (IAaveLendingPool) {
        address lendingPool = ILendingPoolAddressesProvider(platformAddress)
            .getLendingPool();
        require(lendingPool != address(0), "Lending pool does not exist");
        return IAaveLendingPool(lendingPool);
    }

    /**
     * @dev Collect stkAave, convert it to AAVE send to Vault.
     */
    
}
