pragma solidity ^0.5.4;

import "../KeepRandomBeaconOperator.sol";

contract KeepRandomBeaconOperatorRewardsStub is KeepRandomBeaconOperator {

    constructor(
        address _serviceContract,
        address _stakingContract
    ) KeepRandomBeaconOperator(_serviceContract, _stakingContract) public {
        groups.groupActiveTime = 5;
        groups.relayEntryTimeout = 10;
    }

    function registerNewGroup(bytes storage groupPublicKey) public {
        groups.addGroup(groupPublicKey);
    }

    function setGroupMembers(bytes storage groupPublicKey, address[] storage members) public {
        groups.setGroupMembers(groupPublicKey, members, hex"");
    }

    function addGroupMemberReward(bytes memory groupPubKey, uint256 groupMemberReward) public {
        groups.addGroupMemberReward(groupPubKey, groupMemberReward);
    }

    function emitRewardsWithdrawnEvent(address operator, uint256 groupIndex) public {
        emit GroupMemberRewardsWithdrawn(stakingContract.magpieOf(operator), operator, 1000 wei, groupIndex);
    }

}