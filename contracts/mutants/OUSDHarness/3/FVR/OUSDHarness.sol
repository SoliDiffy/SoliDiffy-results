pragma solidity 0.5.11;
import "../../contracts/contracts/token/OUSD.sol";

contract OUSDHarness is OUSD {
	function Certora_maxSupply() public view returns (uint) { return MAX_SUPPLY; }
	function Certora_isNonRebasingAccount(address account) public returns (bool) { return _isNonRebasingAccount(account); }


	function init_state() public { 
		rebasingCreditsPerToken = 1e18; // TODO: Guarantee this is updated
	}
}