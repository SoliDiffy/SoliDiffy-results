// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "./StorageUtils.sol";
import "./SponsorshipUtils.sol";
import "./WithdrawalUtils.sol";
import "../utils/ExtendedMulticall.sol";
import "./interfaces/IAirnodeProtocol.sol";

/// @title Airnode request–response protocol (RRP) and its relayed version
/// @notice Similar to HTTP, RRP allows the requester to specify a one-off
/// request that the Airnode is expected to respond to as soon as possible.
/// The relayed version allows the requester to specify an Airnode that will
/// sign the fulfillment data and a relayer that will report the signed
/// fulfillment.
/// @dev This contract inherits Multicall for Airnodes to be able to make batch
/// static calls to read sponsorship states, and template and subscription
/// details.
/// StorageUtils, SponsorshipUtils and WithdrawalUtils also implement some
/// auxiliary functionality for PSP.
contract AirnodeProtocol is
    StorageUtils,
    SponsorshipUtils,
    WithdrawalUtils,
    ExtendedMulticall,
    IAirnodeProtocol
{
    using ECDSA for bytes32;

    /// @notice Number of requests the requester made
    /// @dev This can be used to calculate the ID of the next request that the
    /// requester will make
    mapping(address => uint256) public override requesterToRequestCount;

    mapping(bytes32 => bytes32) private requestIdToFulfillmentParameters;

    /// @notice Called by the requester to make a request
    /// @dev If the `templateId` is zero, the fulfillment will be made with
    /// `parameters` being used as fulfillment data
    /// @param templateId Template ID
    /// @param parameters Parameters provided by the requester in addition to
    /// the parameters in the template
    /// @param sponsor Sponsor address
    /// @param fulfillFunctionId Selector of the function to be called for
    /// fulfillment
    /// @return requestId Request ID
    

    /// @notice Called by the Airnode using the sponsor wallet to fulfill the
    /// request
    /// @dev Airnodes attest to controlling their respective sponsor wallets by
    /// signing a message with the address of the sponsor wallet. A timestamp
    /// is added to this signature for it to act as an expiring token if the
    /// requester contract checks for freshness.
    /// This will not revert depending on the external call. However, it will
    /// return `false` if the external call reverts or if there is no function
    /// with a matching signature at `fulfillAddress`. On the other hand, it
    /// will return `true` if the external call returns successfully or if
    /// there is no contract deployed at `fulfillAddress`.
    /// If `callSuccess` is `false`, `callData` can be decoded to retrieve the
    /// revert string.
    /// This function emits its event after an untrusted low-level call,
    /// meaning that the log indices of these events may be off.
    /// @param requestId Request ID
    /// @param airnode Airnode address
    /// @param requester Requester address
    /// @param fulfillFunctionId Selector of the function to be called for
    /// fulfillment
    /// @param timestamp Timestamp used in the signature
    /// @param data Fulfillment data, encoded in contract ABI
    /// @param signature Request ID, a timestamp and the sponsor wallet address
    /// signed by the Airnode wallet
    /// @return callSuccess If the fulfillment call succeeded
    /// @return callData Data returned by the fulfillment call (if there is
    /// any)
    

    /// @notice Called by the Airnode using the sponsor wallet if the request
    /// cannot be fulfilled
    /// @dev The Airnode should fall back to this if a request cannot be
    /// fulfilled because of an error, including the static call to `fulfill()`
    /// returning `false` for `callSuccess`.
    /// @param requestId Request ID
    /// @param airnode Airnode address
    /// @param requester Requester address
    /// @param fulfillFunctionId Selector of the function to be called for
    /// fulfillment
    /// @param timestamp Timestamp used in the signature
    /// @param errorMessage A message that explains why the request has failed
    /// @param signature Request ID, a timestamp and the sponsor wallet address
    /// signed by the Airnode address
    

    /// @notice Called by the requester to make a request to be fulfilled by a
    /// relayer
    /// @dev The relayer address indexed in the relayed protocol logs because
    /// it will be the relayer that will be listening to these logs
    /// @param templateId Template ID
    /// @param parameters Parameters provided by the requester in addition to
    /// the parameters in the template
    /// @param relayer Relayer address
    /// @param sponsor Sponsor address
    /// @param fulfillFunctionId Selector of the function to be called for
    /// fulfillment
    /// @return requestId Request ID
    

    /// @notice Called by the relayer using the sponsor wallet to fulfill the
    /// request with the Airnode-signed response
    /// @dev The Airnode must verify the integrity of the request details,
    /// template details, sponsor address–sponsor wallet address consistency
    /// before signing the response
    /// @param requestId Request ID
    /// @param airnode Airnode address
    /// @param requester Requester address
    /// @param relayer Relayer address
    /// @param fulfillFunctionId Selector of the function to be called for
    /// fulfillment
    /// @param timestamp Timestamp used in the signature
    /// @param data Fulfillment data
    /// @param signature Request ID, a timestamp, the sponsor wallet address
    /// and the fulfillment data signed by the Airnode address
    /// @return callSuccess If the fulfillment call succeeded
    /// @return callData Data returned by the fulfillment call (if there is
    /// any)
    

    /// @notice Called by the relayer using the sponsor wallet if the request
    /// cannot be fulfilled
    /// @dev Since failure may also include problems at the Airnode end (such
    /// as it being unavailable), we are content with a signature from the
    /// relayer to validate failures. This is acceptable because explicit
    /// failures are mainly for easy debugging of issues, and the requester
    /// should always consider denial of service from a relayer or an Airnode
    /// to be a possibility.
    /// @param requestId Request ID
    /// @param airnode Airnode address
    /// @param requester Requester address
    /// @param relayer Relayer address
    /// @param timestamp Timestamp used in the signature
    /// @param errorMessage A message that explains why the request has failed
    /// @param signature Request ID, a timestamp and the sponsor wallet address
    /// signed by the relayer address
    function failRequestRelayed(
        bytes32 requestId,
        address airnode,
        address requester,
        address relayer,
        bytes4 fulfillFunctionId,
        uint256 timestamp,
        string calldata errorMessage,
        bytes calldata signature
    ) external override {
        require(
            keccak256(
                abi.encodePacked(airnode, requester, relayer, fulfillFunctionId)
            ) == requestIdToFulfillmentParameters[requestId],
            "Invalid request fulfillment"
        );
        require(
            (
                keccak256(abi.encodePacked(requestId, timestamp, msg.sender))
                    .toEthSignedMessageHash()
            ).recover(signature) == relayer,
            "Signature mismatch"
        );
        delete requestIdToFulfillmentParameters[requestId];
        emit FailedRequestRelayed(
            relayer,
            requestId,
            airnode,
            timestamp,
            errorMessage
        );
    }

    /// @notice Returns if the request with the ID is made but not
    /// fulfilled/failed yet
    /// @dev If a requester has made a request, received a request ID but did
    /// not hear back, it can call this method to check if the Airnode/relayer
    /// called back `failRequest()`/`failRequestRelayed()` instead.
    /// @param requestId Request ID
    /// @return If the request is awaiting fulfillment
    function requestIsAwaitingFulfillment(bytes32 requestId)
        external
        view
        override
        returns (bool)
    {
        return requestIdToFulfillmentParameters[requestId] != bytes32(0);
    }
}
