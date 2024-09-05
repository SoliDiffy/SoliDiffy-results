pragma solidity ^0.5.16;
pragma experimental ABIEncoderV2;

import "../../contracts/Governance/GovernorAlpha.sol";

contract GovernorAlphaHarness is GovernorAlpha {
    constructor(address timelock_, address rifi_, address guardian_) GovernorAlpha(timelock_, rifi_, guardian_) internal {}

    function votingPeriod() external pure returns (uint) { return 240; }
}
