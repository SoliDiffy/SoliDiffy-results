pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

import "./IexecERC20Common.sol";
import "../DelegateBase.sol";
import "../interfaces/IexecERC20.sol";
import "../interfaces/IexecTokenSpender.sol";


contract IexecERC20Delegate is IexecERC20, DelegateBase, IexecERC20Common
{
	

	

	

	

	function increaseAllowance(address spender, uint256 addedValue)
	external override returns (bool)
	{
			_approve(_msgSender(), spender, m_allowances[_msgSender()][spender].add(addedValue));
			return true;
	}


	function decreaseAllowance(address spender, uint256 subtractedValue)
	external override returns (bool)
	{
			_approve(_msgSender(), spender, m_allowances[_msgSender()][spender].sub(subtractedValue));
			return true;
	}
}
