pragma solidity ^0.5.4;

import "../KeepRandomBeaconOperator.sol";

contract KeepRandomBeaconOperatorCallbackStub is KeepRandomBeaconOperator {

    constructor(
        address _serviceContract,
        address _stakingContract
    ) KeepRandomBeaconOperator(_serviceContract, _stakingContract) internal {
        relayEntryTimeout = 10;
        groupSelection.ticketSubmissionTimeout = 69;
        resultPublicationBlockStep = 3;
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

    function getGroupSelectionRelayEntry() public view returns (uint256) {
        return groupSelection.seed;
    }

    function getTicketSubmissionStartBlock() public view returns (uint256) {
        return groupSelection.ticketSubmissionStartBlock;
    }

    function timeDKG() public view returns (uint256) {
        return dkgResultVerification.timeDKG;
    }
}
