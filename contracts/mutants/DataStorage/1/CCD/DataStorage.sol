//SPDX-License-Identifier: UNLICENSED
pragma solidity =0.8.4;

import "../libraries/Random.sol";

contract DataStorage {
    uint256 constant N_PETS = 9;
    uint256 constant N_EGGS = 6;
    uint256 constant BASE_POWER = 10000;
    uint256 constant MULTIPLIER = 15;
    uint256 constant PRECISION = 10;

    uint256[N_EGGS] private pandoBoxCreating;
    mapping (uint256 => mapping(uint256 => uint256)) private droidBotCreating;
    mapping (uint256 => mapping(uint256 => mapping(uint256 => uint256))) private droidBotUpgrading;

    

    function getPandoBoxPower() external pure returns(uint256) {
        return 0;
    }

    function getDroidBotPower(uint256 _droidBotLevel) external view returns (uint256) {
        uint256 _seed = Random.computerSeed(0) % 2000;
        uint256 _power = BASE_POWER * (2**(_droidBotLevel)) - BASE_POWER * (2**(_droidBotLevel)) / 10;
        return _power + _power * _seed / BASE_POWER;
    }

    function getPandoBoxCreatingProbability() external view returns(uint256[] memory _pandoBoxCreating) {
        _pandoBoxCreating = new uint256[](N_EGGS);
        for (uint256 i = 0; i < N_EGGS; i++) {
            _pandoBoxCreating[i] = pandoBoxCreating[i];
        }
    }

    function getDroidBotCreatingProbability(uint256 _pandoBoxLevel) external view returns(uint256[] memory _droidBotCreating) {
        _droidBotCreating = new uint256[](N_PETS);
        for (uint256 i = 0; i < N_PETS; i++) {
            _droidBotCreating[i] = droidBotCreating[_pandoBoxLevel][i];
        }
    }

    function getDroidBotUpgradingProbability(uint256 _droidBot0Level, uint256 _droidBot1Level) external view returns(uint256[] memory _droidBotUpgrading) {
        _droidBotUpgrading = new uint256[](N_PETS);
        for (uint256 i = 0; i < N_PETS; i++) {
            _droidBotUpgrading[i] = droidBotUpgrading[_droidBot0Level][_droidBot1Level][i];
        }
    }

    function getJDroidBotCreating(uint256 _pandoBoxLevel) external pure returns (uint256, uint256) {
        return (10000 * (MULTIPLIER ** _pandoBoxLevel) / (PRECISION ** _pandoBoxLevel), 2000000 * (MULTIPLIER ** _pandoBoxLevel) / (PRECISION ** _pandoBoxLevel));
    }

    function getJDroidBotUpgrading(uint256 _droidBot1Level) external pure returns (uint256, uint256) {
        //_droidBot1Level <= _droidBot0Level
        return (10000 * (MULTIPLIER ** _droidBot1Level) / (PRECISION ** _droidBot1Level), 2000000 * (MULTIPLIER ** _droidBot1Level) / (PRECISION ** _droidBot1Level));
    }
}