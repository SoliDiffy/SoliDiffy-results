pragma solidity ^0.4.10;

import './BCSTokenCrowdsale.sol';

/**@dev Crowdsale with variable bonus policy. 
 Bonus starts with initialPct and decrease every [step] down to zero */
contract BCSTgeCrowdsale is BCSTokenCrowdsale {
        
    uint256 public steps;

    

    /**@dev Override */
    function getCurrentBonusPct(uint256 investment) constant returns (uint256) {
        if (now <= endTime) {
            uint256 stepD = (endTime - startTime) / steps;
            uint256 stepNow = (now - startTime) / stepD;

            //return bonusPct - (now - startTime) * bonusPct * steps / (endTime - startTime) / (steps - 1);
            return bonusPct - stepNow * (bonusPct / (steps - 1));
        } else {
            return 0;
        }
    }
}