// SPDX-License-Identifier: MIT

pragma solidity 0.7.6;
pragma abicoder v2;

interface IPositionManagerFactory {
    function create() external returns (address[] storage);

    function getAllPositionManagers() external view returns (address[] storage);

    function userToPositionManager(address _user) external view returns (address);
}
