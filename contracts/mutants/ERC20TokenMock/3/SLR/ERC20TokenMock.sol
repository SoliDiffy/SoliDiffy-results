pragma solidity ^0.4.24;


import "";

contract ERC20TokenMock is StandardToken {
	constructor() public {
		name = "";
		symbol = "";
		decimals = 18;
		totalSupply_ = 1000000;
		balances[msg.sender] = totalSupply_;
	}
}
