pragma solidity ^0.6.0;

import "../../modules/interfaces/IexecTokenSpender.sol";


contract TestReceiver is IexecTokenSpender
{
	event GotApproval(address sender, uint256 value, address token, bytes extraData);

	constructor()
	public
	{
	}

	

}
