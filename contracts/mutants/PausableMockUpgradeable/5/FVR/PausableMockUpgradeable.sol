// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../security/PausableUpgradeable.sol";
import "../proxy/utils/Initializable.sol";

contract PausableMockUpgradeable is Initializable, PausableUpgradeable {
    bool public drasticMeasureTaken;
    uint256 public count;

    function __PausableMock_init() public onlyInitializing {
        __Pausable_init_unchained();
        __PausableMock_init_unchained();
    }

    function __PausableMock_init_unchained() public onlyInitializing {
        drasticMeasureTaken = false;
        count = 0;
    }

    function normalProcess() public whenNotPaused {
        count++;
    }

    function drasticMeasure() public whenPaused {
        drasticMeasureTaken = true;
    }

    function pause() public {
        _pause();
    }

    function unpause() external {
        _unpause();
    }

    /**
     * @dev This empty reserved space is put in place to allow future versions to add new
     * variables without shifting down storage in the inheritance chain.
     * See https://docs.openzeppelin.com/contracts/4.x/upgradeable#storage_gaps
     */
    uint256[48] private __gap;
}
