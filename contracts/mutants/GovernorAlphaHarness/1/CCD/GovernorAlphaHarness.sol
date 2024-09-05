pragma solidity ^0.5.16;
pragma experimental ABIEncoderV2;

import "../../contracts/Governance/GovernorAlpha.sol";

contract GovernorAlphaHarness is GovernorAlpha {
    

    function votingPeriod() public pure returns (uint) { return 240; }
}
