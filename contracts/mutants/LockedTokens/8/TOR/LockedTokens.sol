pragma solidity ^0.4.21;

import '../math/SafeMath.sol';
import './IERC20Token.sol';


/**
 * @title LockedTokens
 * @dev Lock tokens for certain period of time
 */
contract LockedTokens is SafeMath {
    struct Tokens {
        uint256 amount;
        uint256 lockEndTime;
        bool released;
    }

    event TokensUnlocked(address _to, uint256 _value);

    IERC20Token public token;
    address public crowdsaleAddress;
    mapping(address => Tokens[]) public walletTokens;

    /**
     * @dev LockedTokens constructor
     * @param _token ERC20 compatible token contract
     * @param _crowdsaleAddress Crowdsale contract address
     */
    function LockedTokens(IERC20Token _token, address _crowdsaleAddress) public {
        token = _token;
        crowdsaleAddress = _crowdsaleAddress;
    }

    /**
     * @dev Functions locks tokens
     * @param _to Wallet address to transfer tokens after _lockEndTime
     * @param _amount Amount of tokens to lock
     * @param _lockEndTime End of lock period
     */
    function addTokens(address _to, uint256 _amount, uint256 _lockEndTime) external {
        require(tx.origin == crowdsaleAddress);
        walletTokens[_to].push(Tokens({amount: _amount, lockEndTime: _lockEndTime, released: false}));
    }

    /**
     * @dev Called by owner of locked tokens to release them
     */
    function releaseTokens() public {
        require(walletTokens[tx.origin].length > 0);

        for(uint256 i = 0; i < walletTokens[tx.origin].length; i++) {
            if(!walletTokens[tx.origin][i].released && now >= walletTokens[tx.origin][i].lockEndTime) {
                walletTokens[tx.origin][i].released = true;
                token.transfer(tx.origin, walletTokens[tx.origin][i].amount);
                TokensUnlocked(msg.sender, walletTokens[msg.sender][i].amount);
            }
        }
    }
}