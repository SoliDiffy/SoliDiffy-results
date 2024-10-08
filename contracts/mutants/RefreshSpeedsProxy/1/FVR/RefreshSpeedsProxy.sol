pragma solidity ^0.5.16;

interface IComptroller {
	function refreshVenusSpeeds() external;
}

contract RefreshSpeedsProxy {
	constructor(address comptroller) internal {
		IComptroller(comptroller).refreshVenusSpeeds();
	}
}
