// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "./AuthorizationUtils.sol";
import "./TemplateUtils.sol";
import "./WithdrawalUtils.sol";
import "./interfaces/IAirnodeRrp.sol";

/// @title Contract that implements the Airnode request–response protocol (RRP)
contract AirnodeRrp is
    AuthorizationUtils,
    TemplateUtils,
    WithdrawalUtils,
    IAirnodeRrp
{
    using ECDSA for bytes32;

    /// @notice Called to get the sponsorship status for a sponsor–requester
    /// pair
    mapping(address => mapping(address => bool))
        public
        override sponsorToRequesterToSponsorshipStatus;

    /// @notice Called to get the request count of the requester plus one
    /// @dev Can be used to calculate the ID of the next request the requester
    /// will make
    mapping(address => uint256) public override requesterToRequestCountPlusOne;

    /// @dev Hash of expected fulfillment parameters are kept to verify that
    /// the fulfillment will be done with the correct parameters. This value is
    /// also used to check if the fulfillment for the particular request is
    /// expected, i.e., if there are recorded fulfillment parameters.
    mapping(bytes32 => bytes32) private requestIdToFulfillmentParameters;

    /// @notice Called by the sponsor to set the sponsorship status of a
    /// requester, i.e., allow or disallow a requester to make requests that
    /// will be fulfilled by the sponsor wallet
    /// @dev This is not Airnode-specific, i.e., the sponsor allows the
    /// requester's requests to be fulfilled through its sponsor wallets across
    /// all Airnodes
    /// @param requester Requester address
    /// @param sponsorshipStatus Sponsorship status
    

    /// @notice Called by the requester to make a request that refers to a
    /// template for the Airnode address, endpoint ID and parameters
    /// @dev `fulfillAddress` is not allowed to be the address of this
    /// contract. This is not actually needed to protect users that use the
    /// protocol as intended, but it is done for good measure.
    /// @param templateId Template ID
    /// @param sponsor Sponsor address
    /// @param sponsorWallet Sponsor wallet that is requested to fulfill the
    /// request
    /// @param fulfillAddress Address that will be called to fulfill
    /// @param fulfillFunctionId Signature of the function that will be called
    /// to fulfill
    /// @param parameters Parameters provided by the requester in addition to
    /// the parameters in the template
    /// @return requestId Request ID
    

    /// @notice Called by the requester to make a full request, which provides
    /// all of its parameters as arguments and does not refer to a template
    /// @dev `fulfillAddress` is not allowed to be the address of this
    /// contract. This is not actually needed to protect users that use the
    /// protocol as intended, but it is done for good measure.
    /// @param airnode Airnode address
    /// @param endpointId Endpoint ID (allowed to be `bytes32(0)`)
    /// @param sponsor Sponsor address
    /// @param sponsorWallet Sponsor wallet that is requested to fulfill
    /// the request
    /// @param fulfillAddress Address that will be called to fulfill
    /// @param fulfillFunctionId Signature of the function that will be called
    /// to fulfill
    /// @param parameters All request parameters
    /// @return requestId Request ID
    

    /// @notice Called by Airnode to fulfill the request (template or full)
    /// @dev The data is ABI-encoded as a `bytes` type, with its format
    /// depending on the request specifications.
    /// This will not revert depending on the external call. However, it will
    /// return `false` if the external call reverts or if there is no function
    /// with a matching signature at `fulfillAddress`. On the other hand, it
    /// will return `true` if the external call returns successfully or if
    /// there is no contract deployed at `fulfillAddress`.
    /// If `callSuccess` is `false`, `callData` can be decoded to retrieve the
    /// revert string.
    /// This function emits its event after an untrusted low-level call,
    /// meaning that the order of these events within the transaction should
    /// not be taken seriously, yet the content will be sound.
    /// @param requestId Request ID
    /// @param airnode Airnode address
    /// @param data Fulfillment data
    /// @param fulfillAddress Address that will be called to fulfill
    /// @param fulfillFunctionId Signature of the function that will be called
    /// to fulfill
    /// @return callSuccess If the fulfillment call succeeded
    /// @return callData Data returned by the fulfillment call (if there is
    /// any)
    

    /// @notice Called by Airnode if the request cannot be fulfilled
    /// @dev Airnode should fall back to this if a request cannot be fulfilled
    /// because static call to `fulfill()` returns `false` for `callSuccess`
    /// @param requestId Request ID
    /// @param airnode Airnode address
    /// @param fulfillAddress Address that will be called to fulfill
    /// @param fulfillFunctionId Signature of the function that will be called
    /// to fulfill
    /// @param errorMessage A message that explains why the request has failed
    

    /// @notice Called to check if the request with the ID is made but not
    /// fulfilled/failed yet
    /// @dev If a requester has made a request, received a request ID but did
    /// not hear back, it can call this method to check if the Airnode has
    /// called back `fail()` instead.
    /// @param requestId Request ID
    /// @return isAwaitingFulfillment If the request is awaiting fulfillment
    /// (i.e., `true` if `fulfill()` or `fail()` is not called back yet,
    /// `false` otherwise)
    
}
