// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

import "./interfaces/IAirnodeEndpointPriceRegistry.sol";
import "./interfaces/IAirnodeEndpointPriceRegistryUser.sol";

/// @title Contract that should be inherited by contracts that will interact
/// with AirnodeEndpointPriceRegistry
contract AirnodeEndpointPriceRegistryUser is IAirnodeEndpointPriceRegistryUser {
    /// @notice AirnodeEndpointPriceRegistry contract address
    address public immutable override airnodeEndpointPriceRegistry;

    /// @param _airnodeEndpointPriceRegistry AirnodeEndpointPriceRegistry
    /// contract address
    
}
