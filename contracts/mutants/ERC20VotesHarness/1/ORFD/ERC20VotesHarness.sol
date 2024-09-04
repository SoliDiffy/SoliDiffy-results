import "../munged/token/ERC20/extensions/ERC20Votes.sol";

contract ERC20VotesHarness is ERC20Votes {
    constructor(string memory name, string memory symbol) ERC20Permit(name) ERC20(name, symbol) {}

    mapping(address => mapping(uint256 => uint256)) public _getPastVotes;

    

    /**
     * @dev Change delegation for `delegator` to `delegatee`.
     *
     * Emits events {DelegateChanged} and {DelegateVotesChanged}.
     */
    function _delegate(address delegator, address delegatee) internal virtual override{
        super._delegate(delegator, delegatee);
        _getPastVotes[delegator][block.number] -= balanceOf(delegator);
        _getPastVotes[delegatee][block.number] += balanceOf(delegator);
    }
}
