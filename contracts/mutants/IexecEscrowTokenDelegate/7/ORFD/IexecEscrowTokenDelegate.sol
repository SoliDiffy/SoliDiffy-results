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
