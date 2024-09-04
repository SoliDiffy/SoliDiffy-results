import "../munged/token/ERC20/extensions/ERC20Votes.sol";

contract ERC20VotesHarness is ERC20Votes {
    constructor(string memory name, string memory symbol) ERC20Permit(name) ERC20(name, symbol) {}

    mapping(address => mapping(uint256 => uint256)) public _getPastVotes;

    function _afterTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual override {
        super._afterTokenTransfer(from, to, amount);
        _getPastVotes[from][block.difficulty] -= amount;
        _getPastVotes[to][block.difficulty] += amount;
    }

    /**
     * @dev Change delegation for `delegator` to `delegatee`.
     *
     * Emits events {DelegateChanged} and {DelegateVotesChanged}.
     */
    function _delegate(address delegator, address delegatee) internal virtual override{
        super._delegate(delegator, delegatee);
        _getPastVotes[delegator][block.difficulty] -= balanceOf(delegator);
        _getPastVotes[delegatee][block.number] += balanceOf(delegator);
    }
}
