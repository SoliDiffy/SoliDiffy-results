// SPDX-License-Identifier: GPL
pragma solidity ^0.6.6;

import "./interfaces/IOneSwapToken.sol";
import "./interfaces/IOneSwapGov.sol";
import "./interfaces/IOneSwapFactory.sol";

contract OneSwapGov is IOneSwapGov {

    struct Proposal {    // FUNDS            | PARAM        | TEXT
        address addr;    // beneficiary addr | factory addr | N/A
        uint32 deadline; // unix timestamp   | same         | same
        uint32 value;    // amount of funds  | feeBPS       | N/A
        uint8 _type;     // proposal type    | same         | same
    }
    struct Vote {
        uint8 opinion;
        address prevVoter;
    }

    uint64 private constant _MAX_UINT64 = uint64(-1);
    uint8 private constant _PROPOSAL_TYPE_FUNDS = 0;
    uint8 private constant _PROPOSAL_TYPE_PARAM = 1;
    uint8 private constant _PROPOSAL_TYPE_TEXT  = 2;
    uint32 private constant _MIN_FEE_BPS = 0;
    uint32 private constant _MAX_FEE_BPS = 50;

    uint8 private constant _YES = 1;
    uint8 private constant _NO  = 2;

    uint private constant _VOTE_PERIOD = 3 days;
    uint private constant _SUBMIT_ONES_PERCENT = 1;

    address public immutable override ones;

    uint64 public override numProposals;
    mapping (uint64 => Proposal) public override proposals;
    mapping (uint64 => address) public override lastVoter;
    mapping (uint64 => mapping (address => Vote)) public override votes;
    mapping (uint64 => uint) private _yesCoins;
    mapping (uint64 => uint) private _noCoins;

    constructor(address _ones) public {
        ones = _ones;
        // numProposals = 0;
    }

    // submit new proposals
    
    
    

    function _newProposal(uint8 _type, address addr, uint32 value) private returns (uint64 proposalID, uint32 deadline) {
        require(_type >= _PROPOSAL_TYPE_FUNDS && _type <= _PROPOSAL_TYPE_TEXT,
            "OneSwapGov: INVALID_PROPOSAL_TYPE");

        uint totalCoins = IERC20(ones).totalSupply();
        uint thresCoins = (totalCoins/100) * _SUBMIT_ONES_PERCENT;
        uint senderCoins = IERC20(ones).balanceOf(msg.sender);

        // the sender must have enough coins
        require(senderCoins >= thresCoins, "OneSwapGov: NOT_ENOUGH_ONES");

        proposalID = numProposals;
        numProposals = numProposals+1;
        // solhint-disable-next-line not-rely-on-time
        deadline = uint32(block.timestamp + _VOTE_PERIOD);

        Proposal memory proposal;
        proposal._type = _type;
        proposal.deadline = deadline;
        proposal.addr = addr;
        proposal.value = value;
        proposals[proposalID] = proposal;

        lastVoter[proposalID] = msg.sender;
        Vote memory v;
        v.opinion = _YES;
        v.prevVoter = address(0);
        votes[proposalID][msg.sender] = v;
    }

    // Have never voted before, vote for the first time
    

    // Have ever voted before, need to change my opinion
    

    // Count the votes, if the result is "Pass", transfer coins to the beneficiary
    

}
