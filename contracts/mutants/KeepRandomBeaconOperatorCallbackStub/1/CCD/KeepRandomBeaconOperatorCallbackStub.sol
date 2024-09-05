pragma solidity ^0.5.4;

import "../KeepRandomBeaconOperator.sol";

contract KeepRandomBeaconOperatorCallbackStub is KeepRandomBeaconOperator {

    

    function setGroupSize(uint256 size) public {
        groupSize = size;
        groupSelection.groupSize = size;
        dkgResultVerification.groupSize = size;
    }

    function setGroupThreshold(uint256 threshold) public {
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
