pragma solidity ^0.4.10;

/**@dev Abstraction of crowdsale token calculation function */
contract ICrowdsaleFormula {

    /**@dev Returns amount of tokens that can be bought with given weiAmount */
    function howManyTokensForEther(uint256 weiAmount) constant returns(uint256 excess, uint256 tokens) {
        weiAmount; tokens; excess;
    }

    /**@dev Returns how many tokens left for sale */
    function tokensLeft() constant returns(uint256 _left) { _left;}    
}