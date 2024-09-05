import "../crytic-export/flattening/BPool.sol";
import "./MyToken.sol";
import "./CryticInterface.sol";

contract TBPoolBalance is BPool, CryticInterface {

    MyToken public token;
    uint internal initial_token_balance = uint(-1);

    

    function echidna_attacker_token_balance() public returns(bool){
        // An attacker cannot obtain more tokens than its initial balance
        return token.balanceOf(crytic_attacker) == initial_token_balance/3; //initial balance of crytic_attacker
    }

    function echidna_pool_record_balance() public returns (bool) {
        // If the token was unbinded, avoid revert and return true
        if (this.getNumTokens() == 0)
            return true; 
        // The token balance should not be out-of-sync
        return (token.balanceOf(address(this)) >= this.getBalance(address(token)));
    }
}
