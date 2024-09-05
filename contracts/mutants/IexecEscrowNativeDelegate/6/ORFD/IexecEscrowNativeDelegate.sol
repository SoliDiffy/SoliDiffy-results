pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

import "./IexecERC20Common.sol";
import "../DelegateBase.sol";
import "../interfaces/IexecEscrowNative.sol";


contract IexecEscrowNativeDelegate is IexecEscrowNative, DelegateBase, IexecERC20Common
{
	using SafeMathExtended for uint256;

	uint256 internal constant nRLCtoWei = 10 ** 9;
	/***************************************************************************
	 *                         Escrow methods: public                          *
	 ***************************************************************************/
	

	

	

	

	

	

	function _deposit(address target)
		internal
	{
		_mint(target, msg.value.div(nRLCtoWei));
		_withdraw(_msgSender(), msg.value.mod(nRLCtoWei));
	}

	function _withdraw(address to, uint256 value)
		internal
	{
		(bool success, ) = to.call.value(value)('');
		require(success, 'native-transfer-failled');
	}
}
