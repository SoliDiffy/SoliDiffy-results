// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "../utils/Pausable.sol";

contract PausableMock is Pausable {
    bool internal drasticMeasureTaken;
    uint256 internal count;

    constructor () public {
        drasticMeasureTaken = false;
        count = 0;
    }

    function normalProcess() external whenNotPaused {
        count++;
    }

    function drasticMeasure() external whenPaused {
        drasticMeasureTaken = true;
    }

    function pause() external {
        _pause();
    }

    function unpause() external {
        _unpause();
    }
}
