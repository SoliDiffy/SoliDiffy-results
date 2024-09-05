pragma solidity ^0.5.4;

import "../KeepRandomBeaconOperator.sol";

/**
 * @title KeepRandomBeaconOperatorStub
 * @dev A simplified Random Beacon operator contract to help local development.
 */
contract KeepRandomBeaconOperatorStub is KeepRandomBeaconOperator {

    constructor(
        address _serviceContract,
        address _stakingContract
    ) KeepRandomBeaconOperator(_serviceContract, _stakingContract) internal {
        relayEntryTimeout = 10;
        groupSelection.ticketSubmissionTimeout = 69;
        resultPublicationBlockStep = 3;
    }

    function registerNewGroup(bytes memory groupPublicKey) external {
        groups.addGroup(groupPublicKey);
    }

    function setGroupMembers(bytes memory groupPublicKey, address[] memory members) external {
        groups.setGroupMembers(groupPublicKey, members, hex"");
    }

    function setGroupSize(uint256 size) external {
        groupSize = size;
        groupSelection.groupSize = size;
        dkgResultVerification.groupSize = size;
    }

    function setGroupThreshold(uint256 threshold) external {
        groupThreshold = threshold;
        dkgResultVerification.signatureThreshold = threshold;
    }

    function getGroupSelectionRelayEntry() external view returns (uint256) {
        return groupSelection.seed;
    }

    function getTicketSubmissionStartBlock() external view returns (uint256) {
        return groupSelection.ticketSubmissionStartBlock;
    }

    function isGroupSelectionInProgress() external view returns (bool) {
        return groupSelection.inProgress;
    }

    function getRelayEntryTimeout() external view returns (uint256) {
        return relayEntryTimeout;
    }

    function getGroupPublicKey(uint256 groupIndex) external view returns (bytes memory) {
        return groups.groups[groupIndex].groupPubKey;
    }

    function timeDKG() public view returns (uint256) {
        return dkgResultVerification.timeDKG;
    }
}
