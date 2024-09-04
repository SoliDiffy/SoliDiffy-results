pragma solidity >=0.4.24;

import "../DelayedUpgradeabilityProxy.sol";
import '../../helpers/Ownable.sol';

contract DelayedUpgradeabilityProxyMock is DelayedUpgradeabilityProxy, Ownable {
    constructor(address _implementation) internal DelayedUpgradeabilityProxy(_implementation) {}

    function upgradeTo(address implementation) external onlyOwner {
        _setPendingUpgrade(implementation);
    }
}