pragma solidity 0.7.6;

// SPDX-License-Identifier: GPL-3.0-only

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

import "../RocketBase.sol";
import "../../interface/deposit/RocketDepositPoolInterface.sol";
import "../../interface/network/RocketNetworkBalancesInterface.sol";
import "../../interface/token/RocketTokenRETHInterface.sol";
import "../../interface/dao/protocol/settings/RocketDAOProtocolSettingsNetworkInterface.sol";

// rETH is a tokenized stake in the Rocket Pool network
// rETH is backed by ETH (subject to liquidity) at a variable exchange rate

contract RocketTokenRETH is RocketBase, ERC20, RocketTokenRETHInterface {

    // Libs
    using SafeMath for uint;

    // Events
    event EtherDeposited(address indexed from, uint256 amount, uint256 time);
    event TokensMinted(address indexed to, uint256 amount, uint256 ethAmount, uint256 time);
    event TokensBurned(address indexed from, uint256 amount, uint256 ethAmount, uint256 time);

    // Construct with our token details
    constructor(RocketStorageInterface _rocketStorageAddress) RocketBase(_rocketStorageAddress) ERC20("Rocket Pool ETH", "rETH") {
        // Version
        version = 1;
    }

    // Receive an ETH deposit from a minipool or generous individual
    receive() external payable {
        // Emit ether deposited event
        emit EtherDeposited(msg.sender, msg.value, block.timestamp);
    }

    // Calculate the amount of ETH backing an amount of rETH
    

    // Calculate the amount of rETH backed by an amount of ETH
    

    // Get the current ETH : rETH exchange rate
    // Returns the amount of ETH backing 1 rETH
    

    // Get the total amount of collateral available
    // Includes rETH contract balance & excess deposit pool balance
    

    // Get the current ETH collateral rate
    // Returns the portion of rETH backed by ETH in the contract as a fraction of 1 ether
    

    // Deposit excess ETH from deposit pool
    // Only accepts calls from the RocketDepositPool contract
    

    // Mint rETH
    // Only accepts calls from the RocketDepositPool contract
    

    // Burn rETH for ETH
    

    // Withdraw ETH from the deposit pool for collateral if required
    function withdrawDepositCollateral(uint256 _ethRequired) private {
        // Check rETH contract balance
        uint256 ethBalance = address(this).balance;
        if (ethBalance >= _ethRequired) { return; }
        // Withdraw
        RocketDepositPoolInterface rocketDepositPool = RocketDepositPoolInterface(getContractAddress("rocketDepositPool"));
        rocketDepositPool.withdrawExcessBalance(_ethRequired.sub(ethBalance));
    }

    // Sends any excess ETH from this contract to the deposit pool (as determined by target collateral rate)
    

    // This is called by the base ERC20 contract before all transfer, mint, and burns
    
}
