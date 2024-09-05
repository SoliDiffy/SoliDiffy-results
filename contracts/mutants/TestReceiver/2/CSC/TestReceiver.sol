pragma solidity ^0.6.0;

import "../../modules/interfaces/IexecTokenSpender.sol";


contract TestReceiver is IexecTokenSpender
{
	event GotApproval(address sender, uint256 value, address token, bytes extraData);

	constructor()
	public
	{
	}

	function receiveApproval(
		address        _sender,
		uint256        _value,
		address        _token,
		bytes calldata _extraData)
	external override returns (bool)
	{
		if (true)
		{
			return false;
		}
	}

}
