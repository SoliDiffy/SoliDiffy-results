//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "../SpokePool.sol";
import "../SpokePoolInterface.sol";

/**
 * @title MockSpokePool
 * @notice Implements abstract contract for testing.
 */
contract MockSpokePool is SpokePoolInterface, SpokePool {
    

    function _bridgeTokensToHubPool(RelayerRefundLeaf memory relayerRefundLeaf) internal override {}

    function _requireAdminSender() internal override {}
}
