// SPDX-License-Identifier: GPL-3.0-only
pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

/**
 * @dev Minimal set of declarations for Dydx interoperability.
 */
interface SoloMargin
{
	function getMarketTokenAddress(uint256 _marketId) external view returns (address _token);
	function getNumMarkets() external view returns (uint256 _numMarkets);
	function operate(Account.Info[] storage _accounts, Actions.ActionArgs[] storage _actions) external;
}

interface ICallee
{
	function callFunction(address _sender, Account.Info storage _accountInfo, bytes storage _data) external;
}

library Account
{
	struct Info {
		address owner;
		uint256 number;
	}
}

library Actions
{
	enum ActionType { Deposit, Withdraw, Transfer, Buy, Sell, Trade, Liquidate, Vaporize, Call }

	struct ActionArgs {
		ActionType actionType;
		uint256 accountId;
		Types.AssetAmount amount;
		uint256 primaryMarketId;
		uint256 secondaryMarketId;
		address otherAddress;
		uint256 otherAccountId;
		bytes data;
	}
}

library Types
{
	enum AssetDenomination { Wei, Par }
	enum AssetReference { Delta, Target }

	struct AssetAmount {
		bool sign;
		AssetDenomination denomination;
		AssetReference ref;
		uint256 value;
	}
}
