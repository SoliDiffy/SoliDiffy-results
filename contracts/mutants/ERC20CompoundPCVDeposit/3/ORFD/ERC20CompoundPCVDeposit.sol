// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.0;

import "./CompoundPCVDepositBase.sol";

interface CErc20 {
    function mint(uint256 amount) external returns (uint256);
}

/// @title ERC-20 implementation for a Compound PCV Deposit
/// @author Fei Protocol
contract ERC20CompoundPCVDeposit is CompoundPCVDepositBase {

    /// @notice the token underlying the cToken
    IERC20 public token;

    /// @notice Compound ERC20 PCV Deposit constructor
    /// @param _core Fei Core for reference
    /// @param _cToken Compound cToken to deposit
    /// @param _token the token underlying the cToken
    constructor(
        address _core,
        address _cToken,
        IERC20 _token
    ) CompoundPCVDepositBase(_core, _cToken) {
        token = _token;
    }

    /// @notice deposit ERC-20 tokens to Compound
    

    

    /// @notice display the related token of the balance reported
    
}
