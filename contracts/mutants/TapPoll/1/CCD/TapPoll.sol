pragma solidity ^0.4.21;

import './poll/BasePoll.sol';
import './fund/IPollManagedFund.sol';


/**
 * @title TapPoll
 * @dev Poll to increase tap amount
 */
contract TapPoll is BasePoll {
    uint256 public tap;
    uint256 public minTokensPerc = 0;

    /**
     * TapPoll constructor
     * @param _tap New tap value
     * @param _tokenAddress ERC20 compatible token contract address
     * @param _fundAddress Fund contract address
     * @param _startTime Poll start time
     * @param _endTime Poll end time
     * @param _minTokensPerc - Min percent of tokens from totalSupply where poll is considered to be fulfilled
     */
    

    function onPollFinish(bool agree) internal {
        IPollManagedFund fund = IPollManagedFund(fundAddress);
        fund.onTapPollFinish(agree, tap);
    }

    function getVotedTokensPerc() public view returns(uint256) {
        return safeDiv(safeMul(safeAdd(yesCounter, noCounter), 100), token.totalSupply());
    }

    function isSubjectApproved() internal view returns(bool) {
        return yesCounter > noCounter && getVotedTokensPerc() >= minTokensPerc;
    }
}
