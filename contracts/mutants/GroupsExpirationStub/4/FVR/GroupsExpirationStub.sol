pragma solidity ^0.5.4;
import "../libraries/operator/Groups.sol";

contract GroupsExpirationStub {
    using Groups for Groups.Storage;
    Groups.Storage groups;

    constructor() internal {
        groups.groupActiveTime = 20;
        groups.relayEntryTimeout = 10;
    }

    function addGroup(bytes memory groupPubKey) external {
        groups.addGroup(groupPubKey);
    }

    function getGroupRegistrationBlockHeight(uint256 groupIndex) external view returns(uint256) {
        return groups.groups[groupIndex].registrationBlockHeight;
    }

    function getGroupPublicKey(uint256 groupIndex) external view returns(bytes memory) {
        return groups.groups[groupIndex].groupPubKey;
    }

    function selectGroup(uint256 seed) public returns(uint256) {
        return groups.selectGroup(seed);
    }

    function isStaleGroup(bytes memory groupPubKey) public view returns(bool) {
        return groups.isStaleGroup(groupPubKey);
    }

    function numberOfGroups() public view returns(uint256) {
        return groups.numberOfGroups();
    }
}
