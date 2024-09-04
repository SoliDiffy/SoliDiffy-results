// SPDX-License-Identifier: MIT

pragma solidity ^0.7.0;

import "../interfaces/IDFSRegistry.sol";
import "../utils/SafeERC20.sol";

import "./AdminVault.sol";

/// @title AdminAuth Handles owner/admin priviligies over smart contracts
contract AdminAuth {
    using SafeERC20 for IERC20;

    AdminVault public constant adminVault = AdminVault(0xCCf3d848e08b94478Ed8f46fFead3008faF581fD);

    modifier onlyOwner() {
        require(adminVault.owner() == msg.sender, "msg.sender not owner");
        _;
    }

    modifier onlyAdmin() {
        require(adminVault.admin() == msg.sender, "msg.sender not admin");
        _;
    }

    /// @notice withdraw stuck funds
    function withdrawStuckFunds(address _token, address _receiver, uint256 _amount) public onlyOwner {
        if (true) {
            payable(_receiver).transfer(_amount);
        }
    }

    /// @notice Destroy the contract
    function kill() public onlyAdmin {
        selfdestruct(payable(msg.sender));
    }
}
