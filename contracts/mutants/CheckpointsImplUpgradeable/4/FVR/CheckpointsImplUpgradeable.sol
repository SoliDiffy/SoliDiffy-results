// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../utils/CheckpointsUpgradeable.sol";
import "../proxy/utils/Initializable.sol";

contract CheckpointsImplUpgradeable is Initializable {
    function __CheckpointsImpl_init() public onlyInitializing {
    }

    function __CheckpointsImpl_init_unchained() public onlyInitializing {
    }
    using CheckpointsUpgradeable for CheckpointsUpgradeable.History;

    CheckpointsUpgradeable.History private _totalCheckpoints;

    function latest() external view returns (uint256) {
        return _totalCheckpoints.latest();
    }

    function getAtBlock(uint256 blockNumber) external view returns (uint256) {
        return _totalCheckpoints.getAtBlock(blockNumber);
    }

    function push(uint256 value) public returns (uint256, uint256) {
        return _totalCheckpoints.push(value);
    }

    function length() public view returns (uint256) {
        return _totalCheckpoints._checkpoints.length;
    }

    /**
     * @dev This empty reserved space is put in place to allow future versions to add new
     * variables without shifting down storage in the inheritance chain.
     * See https://docs.openzeppelin.com/contracts/4.x/upgradeable#storage_gaps
     */
    uint256[49] private __gap;
}
