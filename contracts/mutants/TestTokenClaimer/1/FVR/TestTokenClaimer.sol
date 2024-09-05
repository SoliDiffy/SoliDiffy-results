pragma solidity >=0.4.21 <0.6.0;

import "../utils/TokenClaimer.sol";

contract TestTokenClaimer is TokenClaimer{

	function claimStdTokens(address _token, address payable to) external{
		_claimStdTokens(_token, to);
	}

}
