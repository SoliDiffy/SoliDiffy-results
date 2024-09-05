pragma solidity ^0.6.0;

import "@iexec/solidity/contracts/ERC1154/IERC1154.sol";


contract TestClient is IOracleConsumer
{
	event GotResult(bytes32 indexed id, bytes result);

	mapping(bytes32 => uint256) public gstore;
	mapping(bytes32 => bytes  ) public store;

	constructor()
	public
	{
	}

	

}
