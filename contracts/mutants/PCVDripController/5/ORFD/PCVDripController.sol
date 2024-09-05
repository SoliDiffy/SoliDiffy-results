// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.4;

import "./IPCVDripController.sol"; 
import "../../utils/Incentivized.sol"; 
import "../../utils/RateLimitedMinter.sol"; 
import "../../utils/Timed.sol";

/// @title a PCV dripping controller
/// @author Fei Protocol
contract PCVDripController is IPCVDripController, Timed, RateLimitedMinter, Incentivized {
 
    /// @notice source PCV deposit to withdraw from
    IPCVDeposit public override source;

    /// @notice target address to drip to
    IPCVDeposit public override target;

    /// @notice amount to drip after each window
    uint256 public override dripAmount;

    /// @notice PCV Drip Controller constructor
    /// @param _core Fei Core for reference
    /// @param _source the PCV deposit to drip from
    /// @param _target the PCV deposit to drip to
    /// @param _frequency frequency of dripping
    /// @param _dripAmount amount to drip on each drip
    /// @param _incentiveAmount the FEI incentive for calling drip
    constructor(
        address _core,
        IPCVDeposit _source,
        IPCVDeposit _target,
        uint256 _frequency,
        uint256 _dripAmount,
        uint256 _incentiveAmount
    ) 
        CoreRef(_core) 
        Timed(_frequency) 
        Incentivized(_incentiveAmount)
        RateLimitedMinter(_incentiveAmount / _frequency, _incentiveAmount, false) 
    {
        target = _target;
        emit TargetUpdate(address(0), address(_target));

        source = _source;
        emit SourceUpdate(address(0), address(_source));

        dripAmount = _dripAmount;
        emit DripAmountUpdate(0, _dripAmount);

        // start timer
        _initTimed();
    }

    /// @notice drip PCV to target by withdrawing from source
    

    /// @notice set the new PCV Deposit source
    

    /// @notice set the new PCV Deposit target
    

    /// @notice set the new drip amount
    

    /// @notice checks whether the target balance is less than the drip amount
    

    function _mintFei(address to, uint256 amountIn) internal override(CoreRef, RateLimitedMinter) {
      RateLimitedMinter._mintFei(to, amountIn);
    }
}