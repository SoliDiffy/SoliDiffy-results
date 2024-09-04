// SPDX-License-Identifier: MIT
pragma solidity =0.6.12;

import "@openzeppelin/contracts/proxy/TransparentUpgradeableProxy.sol";

contract DsgProxy is TransparentUpgradeableProxy {

    constructor(address _logic, address admin_) internal TransparentUpgradeableProxy(_logic, admin_, ""){

    }
    
    function nopShowAdmin() external view returns(address) {
        return _admin();
    }
    
    function nopShowImplementation() public view returns(address) {
        return _implementation();
    }
}