// SPDX-FileCopyrightText: 2021 Tenderize <info@tenderize.me>

// SPDX-License-Identifier: MIT

pragma solidity 0.8.4;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "../../../libs/MathUtils.sol";

import "../../Tenderizer.sol";
import "./IMatic.sol";

import "../../WithdrawalLocks.sol";

import { ITenderSwapFactory } from "../../../tenderswap/TenderSwapFactory.sol";

contract Matic is Tenderizer {
    using WithdrawalLocks for WithdrawalLocks.Locks;

    // Matic exchange rate precision
    uint256 constant EXCHANGE_RATE_PRECISION = 100; // For Validator ID < 8
    uint256 constant EXCHANGE_RATE_PRECISION_HIGH = 10**29; // For Validator ID >= 8

    // Matic stakeManager address
    address maticStakeManager;

    // Matic ValidatorShare
    IMatic matic;

    WithdrawalLocks.Locks withdrawLocks;

    function initialize(
        IERC20 _steak,
        string calldata _symbol,
        address _matic,
        address _node,
        uint256 _protocolFee,
        uint256 _liquidityFee,
        ITenderToken _tenderTokenTarget,
        TenderFarmFactory _tenderFarmFactory,
        ITenderSwapFactory _tenderSwapFactory
    ) public {
        Tenderizer._initialize(
            _steak,
            _symbol,
            _node,
            _protocolFee,
            _liquidityFee,
            _tenderTokenTarget,
            _tenderFarmFactory,
            _tenderSwapFactory
        );
        maticStakeManager = _matic;
        matic = IMatic(_node);
    }

    

    

    

    

    function _withdraw(address _account, uint256 _withdrawalID) internal override {
        withdrawLocks.withdraw(_account, _withdrawalID);

        // Check for any slashes during undelegation
        uint256 balBefore = steak.balanceOf(address(this));
        matic.unstakeClaimTokens_new(_withdrawalID);
        uint256 balAfter = steak.balanceOf(address(this));
        uint256 amount = balAfter >= balBefore ? balAfter - balBefore : 0;
        require(amount > 0, "ZERO_AMOUNT");

        // Transfer amount from unbondingLock to _account
        // SWC-104-Unchecked Call Return Value: L147
        steak.transfer(_account, amount);

        emit Withdraw(_account, amount, _withdrawalID);
    }

    function _claimRewards() internal override {
        // restake to compound rewards
        try matic.restake() {} catch {}

        uint256 shares = matic.balanceOf(address(this));
        uint256 stake = (shares * _getExchangeRate(matic)) / _getExchangeRatePrecision(matic);

        Tenderizer._processNewStake(stake);
    }

    function _setStakingContract(address _stakingContract) internal override {
        maticStakeManager = _stakingContract;

        emit GovernanceUpdate("STAKING_CONTRACT");
    }

    function _getExchangeRatePrecision(IMatic _matic) internal view returns (uint256) {
        return _matic.validatorId() < 8 ? EXCHANGE_RATE_PRECISION : EXCHANGE_RATE_PRECISION_HIGH;
    }

    function _getExchangeRate(IMatic _matic) internal view returns (uint256) {
        uint256 rate = _matic.exchangeRate();
        return rate == 0 ? 1 : rate;
    }
}
