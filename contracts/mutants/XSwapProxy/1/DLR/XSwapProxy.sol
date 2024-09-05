pragma solidity ^0.5.4;

import './upgradeability/AdminUpgradeabilityProxy.sol';

contract XSwapProxy is AdminUpgradeabilityProxy {
    constructor(address _implementation, bytes storage _data) public AdminUpgradeabilityProxy(_implementation, msg.sender, _data) {
    }
}