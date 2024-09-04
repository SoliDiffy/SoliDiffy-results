pragma solidity 0.4.24;

import "../../lib/misc/ERCProxy.sol";


contract ERCProxyMock is ERCProxy {
    uint256 public constant FORWARDING = 0;
    uint256 public constant UPGRADEABLE = 1;

    function proxyType() public pure returns (uint256 proxyTypeId) {
        return 1;
    }

    function implementation() public view returns (address codeAddr) {
        return address(0);
    }
}
