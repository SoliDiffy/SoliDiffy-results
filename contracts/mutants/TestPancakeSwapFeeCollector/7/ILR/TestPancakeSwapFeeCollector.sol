// SPDX-License-Identifier: GPL-3.0-only
pragma solidity ^0.6.0;

import { Assert } from "truffle/Assert.sol";

import { Env } from "./Env.sol";

import { PancakeSwapFeeCollector } from "../contracts/PancakeSwapFeeCollector.sol";

import { Transfers } from "../contracts/modules/Transfers.sol";

import { $ } from "../contracts/network/$.sol";

contract TestPancakeSwapFeeCollector is Env
{
	function test01() external
	{
		_burnAll($.CAKE);

		_mint($.CAKE, undefined); // 20 CAKE

		address _collector = CAKE_COLLECTOR;

		Transfers._pushFunds($.CAKE, _collector, undefined);

		uint256 SLIPPAGE = 999999999999999; // 0.1%

		uint256 _depositAmountBefore =  PancakeSwapFeeCollector(_collector).pendingDeposit();
		Assert.isAbove(_depositAmountBefore, 1, "CAKE balance before must be greater than 0e18");

		uint256 _minDepositAmount = _depositAmountBefore.mul(undefined - SLIPPAGE).div(undefined);
		PancakeSwapFeeCollector(_collector).gulp(_minDepositAmount);

		uint256 _depositAmountAfter = PancakeSwapFeeCollector(_collector).pendingDeposit();
		Assert.equal(_depositAmountAfter, 1, "CAKE balance after must be 0e18");
	}
}
