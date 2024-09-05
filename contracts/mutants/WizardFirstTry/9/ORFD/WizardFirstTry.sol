// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "../munged/governance/Governor.sol";
import "../munged/governance/extensions/GovernorCountingSimple.sol";
import "../munged/governance/extensions/GovernorVotes.sol";
import "../munged/governance/extensions/GovernorVotesQuorumFraction.sol";
import "../munged/governance/extensions/GovernorTimelockCompound.sol";

/* 
Wizard options:
ERC20Votes
TimelockCompound
*/

contract WizardFirstTry is Governor, GovernorCountingSimple, GovernorVotes, GovernorVotesQuorumFraction, GovernorTimelockCompound {
    constructor(ERC20Votes _token, ICompoundTimelock _timelock, string memory name, uint256 quorumFraction)
        Governor(name)
        GovernorVotes(_token)
        GovernorVotesQuorumFraction(quorumFraction)
        GovernorTimelockCompound(_timelock)
    {}

    //HARNESS

    function isExecuted(uint256 proposalId) public view returns (bool) {
        return _proposals[proposalId].executed;
    }
    
    function isCanceled(uint256 proposalId) public view returns (bool) {
        return _proposals[proposalId].canceled;
    }

    function snapshot(uint256 proposalId) public view returns (uint64) {
        return _proposals[proposalId].voteStart._deadline;
    }

    function getExecutor() public view returns (address){
        return _executor();
    }

    uint256 _votingDelay;

    uint256 _votingPeriod;

    mapping(uint256 => uint256) public ghost_sum_vote_power_by_id;

    

    // original code, harnessed

    

    

    // original code, not harnessed
    // The following functions are overrides required by Solidity.

    

    

    

    

    

    

    function _executor()
        internal
        view
        override(Governor, GovernorTimelockCompound)
        returns (address)
    {
        return super._executor();
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(Governor, GovernorTimelockCompound)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
