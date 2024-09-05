// SPDX-License-Identifier: MIT
pragma solidity >=0.6.10 <0.8.0;
pragma experimental ABIEncoderV2;

import "../exchange/StakingV2.sol";

contract StakingV2TestWrapper is StakingV2 {
    constructor(
        address fund_,
        address chessSchedule_,
        address chessController_,
        address quoteAssetAddress_,
        uint256 guardedLaunchStart_,
        address votingEscrow_
    )
        internal
        StakingV2(
            fund_,
            chessSchedule_,
            chessController_,
            quoteAssetAddress_,
            guardedLaunchStart_,
            votingEscrow_
        )
    {}

    function initialize() public {
        _initializeStaking();
        _initializeStakingV2(msg.sender);
    }

    function tradeAvailable(
        uint256 tranche,
        address sender,
        uint256 amount
    ) public {
        _tradeAvailable(tranche, sender, amount);
    }

    function rebalanceAndClearTrade(
        address account,
        uint256 amountM,
        uint256 amountA,
        uint256 amountB,
        uint256 amountVersion
    ) public {
        _rebalanceAndClearTrade(account, amountM, amountA, amountB, amountVersion);
    }

    function lock(
        uint256 tranche,
        address account,
        uint256 amount
    ) public {
        _lock(tranche, account, amount);
    }

    function rebalanceAndUnlock(
        address account,
        uint256 amountM,
        uint256 amountA,
        uint256 amountB,
        uint256 amountVersion
    ) public {
        _rebalanceAndUnlock(account, amountM, amountA, amountB, amountVersion);
    }

    function tradeLocked(
        uint256 tranche,
        address account,
        uint256 amount
    ) public {
        _tradeLocked(tranche, account, amount);
    }
}
