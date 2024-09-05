// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

import "../whitelist/WhitelistRolesWithAirnode.sol";
import "./RequesterAuthorizer.sol";
import "./interfaces/IRequesterAuthorizerWithAirnode.sol";

/// @title Authorizer contract that Airnode operators can use to temporarily or
/// indefinitely whitelist requesters for Airnode–endpoint pairs
contract RequesterAuthorizerWithAirnode is
    WhitelistRolesWithAirnode,
    RequesterAuthorizer,
    IRequesterAuthorizerWithAirnode
{
    /// @param _accessControlRegistry AccessControlRegistry contract address
    /// @param _adminRoleDescription Admin role description
    constructor(
        address _accessControlRegistry,
        string memory _adminRoleDescription
    )
        WhitelistRolesWithAirnode(_accessControlRegistry, _adminRoleDescription)
    {}

    /// @notice Extends the expiration of the temporary whitelist of
    /// `requester` for the `airnode`–`endpointId` pair if the sender has the
    /// whitelist expiration extender role
    /// @param airnode Airnode address
    /// @param endpointId Endpoint ID
    /// @param requester Requester address
    /// @param expirationTimestamp Timestamp at which the temporary whitelist
    /// will expire
    

    /// @notice Sets the expiration of the temporary whitelist of `requester`
    /// for the `airnode`–`endpointId` pair if the sender has the whitelist
    /// expiration setter role
    /// @dev Unlike `extendWhitelistExpiration()`, this can hasten expiration
    /// @param airnode Airnode address
    /// @param endpointId Endpoint ID
    /// @param requester Requester address
    /// @param expirationTimestamp Timestamp at which the temporary whitelist
    /// will expire
    

    /// @notice Sets the indefinite whitelist status of `requester` for the
    /// `airnode`–`endpointId` pair if the sender has the indefinite
    /// whitelister role
    /// @param airnode Airnode address
    /// @param endpointId Endpoint ID
    /// @param requester Requester address
    /// @param status Indefinite whitelist status
    

    /// @notice Revokes the indefinite whitelist status granted by a specific
    /// account that no longer has the indefinite whitelister role
    /// @param airnode Airnode address
    /// @param endpointId Endpoint ID
    /// @param requester Requester address
    /// @param setter Setter of the indefinite whitelist status
    
}
