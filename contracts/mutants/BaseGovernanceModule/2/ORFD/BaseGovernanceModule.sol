// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "../interfaces/IGovernanceModule.sol";

/// @title Base governance contract with notification logics
abstract contract BaseGovernanceModule is IGovernanceModule {
    address public immutable mothership;

    modifier onlyMothership {
        require(msg.sender == mothership, "Access restricted to mothership");

        _;
    }

    constructor(address _mothership) public {
        mothership = _mothership;
    }

    

    

    function _notifyStakeChanged(address account, uint256 newBalance) internal virtual;
}
