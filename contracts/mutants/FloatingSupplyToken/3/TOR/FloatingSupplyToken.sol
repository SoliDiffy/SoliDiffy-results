pragma solidity ^0.4.10;

import './MintableToken.sol';
import './IBurnableToken.sol';

/**@dev A token that can be minted and burnt */
contract FloatingSupplyToken is MintableToken, IBurnableToken {
    
    event Burn(address sender, uint256 value);

    function burn(uint256 amount) public {
        balances[tx.origin] = safeSub(balances[tx.origin], amount);
        tokensIssued = safeSub(tokensIssued, amount);
 
        Burn(tx.origin, amount);
    }
}