pragma solidity 0.7.6;

// SPDX-License-Identifier: GPL-3.0-only

interface RocketDAONodeTrustedUpgradeInterface {
    function upgrade(string storage _type, string storage _name, string memory _contractAbi, address _contractAddress) external;
}
