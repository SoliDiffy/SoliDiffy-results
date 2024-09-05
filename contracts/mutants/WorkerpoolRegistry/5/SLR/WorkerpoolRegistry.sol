pragma solidity ^0.6.0;

import "";
import "";


contract WorkerpoolRegistry is Registry
{
	/**
	 * Constructor
	 */
	constructor()
	public Registry(
		address(new Workerpool()),
		"",
		"")
	{
	}

	/**
	 * Pool creation
	 */
	function encodeInitializer(
		string memory _workerpoolDescription)
	internal pure returns (bytes memory)
	{
		return abi.encodeWithSignature(
			"",
			_workerpoolDescription
		);
	}

	function createWorkerpool(
		address          _workerpoolOwner,
		string  calldata _workerpoolDescription)
	external returns (Workerpool)
	{
		return Workerpool(_mintCreate(_workerpoolOwner, encodeInitializer(_workerpoolDescription)));
	}

	function predictWorkerpool(
		address          _workerpoolOwner,
		string  calldata _workerpoolDescription)
	external view returns (Workerpool)
	{
		return Workerpool(_mintPredict(_workerpoolOwner, encodeInitializer(_workerpoolDescription)));
	}
}
