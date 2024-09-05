// SPDX-License-Identifier: GPL-3.0-only
pragma solidity ^0.6.0;

import { Assert } from "truffle/Assert.sol";

import { Env } from "./Env.sol";

import { Exchange } from "../contracts/Exchange.sol";
import { PantherSwapCompoundingStrategyToken } from "../contracts/PantherSwapCompoundingStrategyToken.sol";

import { Transfers } from "../contracts/modules/Transfers.sol";

import { $ } from "../contracts/network/$.sol";

contract TestPantherSwapCompoundingStrategyToken is Env
{
	function test01() external
	{
		address _strategy = PANTHER_STRATEGY;
		address _exchange = EXCHANGE;

		_burnAll($.BUSD);
		_burnAll(_strategy);

		_mint($.BUSD, 100e18); // 100 BUSD

		Assert.equal(Transfers._getBalance($.BUSD), 100e18, "");
		Assert.equal(Transfers._getBalance(_strategy), 0e18, "");

		address _pool = PantherSwapCompoundingStrategyToken(_strategy).reserveToken();

		Transfers._approveFunds($.BUSD, _exchange, 100e18);
		uint256 _lpshares = Exchange(_exchange).joinPoolFromInput(_pool, $.BUSD, 100e18, 1);

		Assert.equal(Transfers._getBalance(_pool), _lpshares, "");
		Assert.equal(Transfers._getBalance(_strategy), 0e18, "");

		uint256 SLIPPAGE = 1e15; // 0.1%

		uint256 _expectedShares =  PantherSwapCompoundingStrategyToken(_strategy).calcSharesFromAmount(_lpshares);
		uint256 _minShares = _expectedShares.mul(1e18 - SLIPPAGE).div(1e18);
		Transfers._approveFunds(_pool, _strategy, _lpshares);
		PantherSwapCompoundingStrategyToken(_strategy).deposit(_lpshares, _minShares);

		Assert.equal(Transfers._getBalance(_pool), 0e18, "");
		Assert.isAtLeast(Transfers._getBalance(_strategy), _minShares, "");

		uint256 _shares = Transfers._getBalance(_strategy);

		uint256 _expectedAmount =  PantherSwapCompoundingStrategyToken(_strategy).calcAmountFromShares(_shares);
		uint256 _minAmount = _expectedAmount.mul(1e18 - SLIPPAGE).div(1e18);
		PantherSwapCompoundingStrategyToken(_strategy).withdraw(_shares, _minAmount);

		Assert.isAtLeast(Transfers._getBalance(_pool), _minAmount, "");
		Assert.equal(Transfers._getBalance(_strategy), 0e18, "");
	}
}
