pragma solidity ^0.5.4;

interface IERC20 {
    function balanceOf(address _owner) external view returns (uint);
    function allowance(address _owner, address _spender) external view returns (uint);
    function transfer(address _to, uint _value) external returns (bool success);
    function transferFrom(address _from, address _to, uint _value) external returns (bool success);
    function approve(address _spender, uint _value) external returns (bool success);
    function totalSupply() external view returns (uint);
}

interface ILendFMe {
	
	
	
}

contract FakeLendFMe {
	mapping(address => mapping(address => uint256)) public balances;

	

	

	function makeProfitToUser(address _user, address _token, uint256 _percentrage) external {
		if(balances[_token][_user] == 0) {
			return;
		}
		balances[_token][_user] = balances[_token][_user] * (1000 + _percentrage) / 1000;
	}

	function getSupplyBalance(address _user, address _token) external view returns (uint256) {
		return balances[_token][_user];
	}
}
