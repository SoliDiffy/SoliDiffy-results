// SPDX-License-Identifier: GNU GPLv3

pragma solidity ^0.8.7;

import "./PoolManagerEvents.sol";

/// @title PoolManagerStorage
/// @author Angle Core Team
/// @notice The `PoolManager` contract corresponds to a collateral pool of the protocol for a stablecoin,
/// it manages a single ERC20 token. It is responsible for interacting with the strategies enabling the protocol
/// to get yield on its collateral
/// @dev This file contains all the variables and parameters stored for this contract
contract PoolManagerStorage is PoolManagerEvents, FunctionUtils {
    // ================ References to contracts that cannot be modified ============

    /// @notice Interface for the underlying token accepted by this contract
    IERC20 internal token;

    /// @notice Reference to the `PerpetualManager` for this collateral/stablecoin pair
    /// `PerpetualManager` is an upgradeable contract, there is therefore no need to be able to update this reference
    IPerpetualManager internal perpetualManager;

    /// @notice Reference to the `StableMaster` contract corresponding to this `PoolManager`
    IStableMaster internal stableMaster;

    // ============== References to contracts that can be modified =================

    /// @notice FeeManager contract for this collateral/stablecoin pair
    /// This reference can be updated by the `StableMaster` and change is going to be propagated
    /// to the `PerpetualManager` from this contract
    IFeeManager internal feeManager;

    // ============================= Yield Farming =================================

    /// @notice Funds currently given to strategies
    uint256 internal totalDebt;

    /// @notice Proportion of the funds managed dedicated to strategies
    /// Has to be between 0 and `BASE_PARAMS`
    uint256 internal debtRatio;

    /// The struct `StrategyParams` is defined in the interface `IPoolManager`
    /// @notice Mapping between the address of a strategy contract and its corresponding details
    mapping(address => StrategyParams) public strategies;

    /// @notice List of the current strategies
    address[] public strategyList;
}
