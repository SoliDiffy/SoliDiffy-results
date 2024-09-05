pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;


interface IexecEscrowNative
{
	receive() external payable;
	function deposit() external  returns (bool);
	function depositFor(address) external  returns (bool);
	function depositForArray(uint256[] calldata,address[] calldata) external  returns (bool);
	function withdraw(uint256) external returns (bool);
	function recover() external returns (uint256);
}
