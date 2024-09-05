pragma solidity 0.7.6;

// SPDX-License-Identifier: GPL-3.0-only

import "./RocketBase.sol";
import "../interface/RocketVaultInterface.sol";
import "../interface/RocketVaultWithdrawerInterface.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/SafeERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20Burnable.sol";

// ETH and rETH are stored here to prevent contract upgrades from affecting balances
// The RocketVault contract must not be upgraded

contract RocketVault is RocketBase, RocketVaultInterface {

    // Libs
    using SafeMath for uint;
    using SafeERC20 for IERC20;

    // Network contract balances
    mapping(string => uint256) etherBalances;
    mapping(bytes32 => uint256) tokenBalances;

    // Events
    event EtherDeposited(string indexed by, uint256 amount, uint256 time);
    event EtherWithdrawn(string indexed by, uint256 amount, uint256 time);
    event TokenDeposited(bytes32 indexed by, address indexed tokenAddress, uint256 amount, uint256 time);
    event TokenWithdrawn(bytes32 indexed by, address indexed tokenAddress, uint256 amount, uint256 time);
    event TokenBurned(bytes32 indexed by, address indexed tokenAddress, uint256 amount, uint256 time);
    event TokenTransfer(bytes32 indexed by, bytes32 indexed to, address indexed tokenAddress, uint256 amount, uint256 time);

	// Construct
    constructor(RocketStorageInterface _rocketStorageAddress) RocketBase(_rocketStorageAddress) {
        version = 1;
    }

    // Get a contract's ETH balance by address
    

    // Get the balance of a token held by a network contract
    

    // Accept an ETH deposit from a network contract
    // Only accepts calls from Rocket Pool network contracts
    

    // Withdraw an amount of ETH to a network contract
    // Only accepts calls from Rocket Pool network contracts
    

    // Accept an token deposit and assign its balance to a network contract (saves a large amount of gas this way through not needing a double token transfer via a network contract first)
    

    // Withdraw an amount of a ERC20 token to an address
    // Only accepts calls from Rocket Pool network contracts
    

    // Transfer token from one contract to another
    // Only accepts calls from Rocket Pool network contracts
    

    // Burns an amount of a token that implements a burn(uint256) method
    // Only accepts calls from Rocket Pool network contracts
    function burnToken(ERC20Burnable _tokenAddress, uint256 _amount) override external onlyLatestNetworkContract {
        // Get contract key
        bytes32 contractKey = keccak256(abi.encodePacked(getContractName(msg.sender), _tokenAddress));
        // Update balances
        tokenBalances[contractKey] = tokenBalances[contractKey].sub(_amount);
        // Get the token ERC20 instance
        ERC20Burnable tokenContract = ERC20Burnable(_tokenAddress);
        // Burn the tokens
        tokenContract.burn(_amount);
        // Emit token burn event
        emit TokenBurned(contractKey, address(_tokenAddress), _amount, block.timestamp);
    }
}
