pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

import "./IexecERC20Common.sol";
import "../DelegateBase.sol";
import "../interfaces/IexecEscrowToken.sol";
import "../interfaces/IexecTokenSpender.sol";


contract IexecEscrowTokenDelegate is IexecEscrowToken, IexecTokenSpender, DelegateBase, IexecERC20Common
{
	using SafeMathExtended for uint256;

	/***************************************************************************
	 *                         Escrow methods: public                          *
	 ***************************************************************************/
	

	

	

	

	

	

	// Token Spender (endpoint for approveAndCallback calls to the proxy)
	function receiveApproval(address sender, uint256 amount, address token, bytes calldata)
	external override returns (bool)
	{
		require(token == address(m_baseToken), 'wrong-token');
		_deposit(sender, amount);
		_mint(sender, amount);
		return true;
	}

	function _deposit(address from, uint256 amount)
	internal
	{
		require(m_baseToken.transferFrom(from, address(this), amount));
	}

	function _withdraw(address to, uint256 amount)
	internal
	{
		m_baseToken.transfer(to, amount);
	}
}
