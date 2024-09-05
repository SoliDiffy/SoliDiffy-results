pragma solidity ^0.5.4;

import './upgradeability/AdminUpgradeabilityProxy.sol';

contract XSwapProxy is AdminUpgradeabilityProxy {
    constructor(address _implementation, bytes memory _data) internal AdminUpgradeabilityProxy(_implementation, msg.sender, _data) {
    }
}