pragma solidity 0.4.24;

import "../IOwnedUpgradeabilityProxy.sol";


contract OwnedUpgradeability {

    function upgradeabilityAdmin() external view returns (address) {
        return IOwnedUpgradeabilityProxy(this).proxyOwner();
    }

    // Avoid using onlyProxyOwner name to prevent issues with implementation from proxy contract
    modifier onlyIfOwnerOfProxy() {
        require(msg.sender == upgradeabilityAdmin());
        _;
    }
}
