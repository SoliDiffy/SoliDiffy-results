pragma solidity ^0.5.4;

import "../KeepRandomBeaconOperator.sol";

contract KeepRandomBeaconOperatorRewardsStub is KeepRandomBeaconOperator {

    constructor(
        address _serviceContract,
        address _stakingContract
    ) KeepRandomBeaconOperator(_serviceContract, _stakingContract) internal {
        groups.groupActiveTime = 5;
        groups.relayEntryTimeout = 10;
    }

    function registerNewGroup(bytes memory groupPublicKey) external {
        groups.addGroup(groupPublicKey);
    }

    function setGroupMembers(bytes memory groupPublicKey, address[] memory members) external {
        groups.setGroupMembers(groupPublicKey, members, hex"");
    }

    function addGroupMemberReward(bytes memory groupPubKey, uint256 groupMemberReward) external {
        groups.addGroupMemberReward(groupPubKey, groupMemberReward);
    }

    function emitRewardsWithdrawnEvent(address operator, uint256 groupIndex) public {
        emit GroupMemberRewardsWithdrawn(stakingContract.magpieOf(operator), operator, 1000 wei, groupIndex);
    }

}