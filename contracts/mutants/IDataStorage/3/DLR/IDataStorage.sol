// SPDX-License-Identifier: MIT

pragma solidity =0.8.4;

interface IDataStorage {
    function getPandoBoxCreatingProbability() external view returns (uint256[] storage);
    function getDroidBotCreatingProbability(uint256) external view returns (uint256[] storage);
    function getDroidBotUpgradingProbability(uint256, uint256) external view returns(uint256[] storage);
    function getDroidBotPower(uint256) external view returns(uint256);
    function getJDroidBotCreating(uint256) external view returns(uint256, uint256);
    function getJDroidBotUpgrading(uint256) view external returns(uint256, uint256);
}