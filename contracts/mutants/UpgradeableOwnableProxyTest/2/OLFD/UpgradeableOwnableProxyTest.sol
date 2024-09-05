// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "openzeppelin-solidity/contracts/token/ERC20/IERC20.sol";
import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "./UpgradeableOwnable.sol";
import "./UpgradeableOwnableProxy.sol";


contract TestImplA is UpgradeableOwnable {
    
}


contract TestImplB is UpgradeableOwnable {
    
}


contract TestRoot is UpgradeableOwnableProxy {
    constructor(address impl) public UpgradeableOwnableProxy(impl, "") {}
}
