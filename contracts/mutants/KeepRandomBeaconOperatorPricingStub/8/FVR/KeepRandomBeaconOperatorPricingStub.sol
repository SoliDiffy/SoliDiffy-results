pragma solidity ^0.5.4;

import "../KeepRandomBeaconOperator.sol";

contract KeepRandomBeaconOperatorPricingStub is KeepRandomBeaconOperator {

    constructor(
        address _serviceContract,
        address _stakingContract
    ) KeepRandomBeaconOperator(_serviceContract, _stakingContract) internal {
    }

    function registerNewGroup(bytes memory groupPublicKey) external {
        groups.addGroup(groupPublicKey);
    }

    function setDkgGasEstimate(uint256 gasEstimate) external {
        dkgGasEstimate = gasEstimate;
    }

    function setEntryVerificationGasEstimate(uint256 gasEstimate) external {
        entryVerificationGasEstimate = gasEstimate;
    }

    function setGroupMemberBaseReward(uint256 reward) external {
        groupMemberBaseReward = reward;
    }

    function setGroupSize(uint256 size) external {
        groupSize = size;
    }

    function setGroupSelectionGasEstimate(uint256 gas) external {
        groupSelectionGasEstimate = gas;
    }

    function getNewEntryRewardsBreakdown() external view returns(
        uint256 groupMemberReward,
        uint256 submitterReward,
        uint256 subsidy
    ) {
        return super.newEntryRewardsBreakdown();
    }

    function delayFactor() public view returns(uint256) {
        return super.getDelayFactor();
    }
}
