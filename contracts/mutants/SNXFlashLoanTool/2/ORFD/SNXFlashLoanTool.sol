// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.7.6;

import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";
import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import { IAddressResolver } from "synthetix/contracts/interfaces/IAddressResolver.sol";
import { ISynthetix } from "synthetix/contracts/interfaces/ISynthetix.sol";
import { ISNXFlashLoanTool } from "./interfaces/ISNXFlashLoanTool.sol";
import { IFlashLoanReceiver } from "./interfaces/IFlashLoanReceiver.sol";
import { ILendingPoolAddressesProvider } from "./interfaces/ILendingPoolAddressesProvider.sol";
import { ILendingPool } from "./interfaces/ILendingPool.sol";
import { SafeERC20 } from "@openzeppelin/contracts/token/ERC20/SafeERC20.sol";
import { SafeMath } from "@openzeppelin/contracts/math/SafeMath.sol";

/// @author Ganesh Gautham Elango
/// @title Burn sUSD debt with SNX using a flash loan
contract SNXFlashLoanTool is ISNXFlashLoanTool, IFlashLoanReceiver, Ownable {
    using SafeMath for uint256;
    using SafeERC20 for IERC20;

    /// @dev Synthetix address
    ISynthetix public immutable synthetix;
    /// @dev SNX token contract
    IERC20 public immutable snx;
    /// @dev sUSD token contract
    IERC20 public immutable sUSD;
    /// @dev Aave LendingPoolAddressesProvider contract
    ILendingPoolAddressesProvider public immutable override ADDRESSES_PROVIDER;
    /// @dev Aave LendingPool contract
    ILendingPool public immutable override LENDING_POOL;
    /// @dev Aave LendingPool referral code
    uint16 public constant referralCode = 185;

    /// @dev Constructor
    /// @param _snxResolver Synthetix AddressResolver address
    /// @param _provider Aave LendingPoolAddressesProvider address
    constructor(address _snxResolver, address _provider) {
        IAddressResolver synthetixResolver = IAddressResolver(_snxResolver);
        synthetix = ISynthetix(synthetixResolver.getAddress("Synthetix"));
        snx = IERC20(synthetixResolver.getAddress("ProxyERC20"));
        sUSD = IERC20(synthetixResolver.getAddress("ProxyERC20sUSD"));
        ILendingPoolAddressesProvider provider = ILendingPoolAddressesProvider(_provider);
        ADDRESSES_PROVIDER = provider;
        LENDING_POOL = ILendingPool(provider.getLendingPool());
    }

    /// @notice Burn sUSD debt with SNX using a flash loan
    /// @dev To burn all sUSD debt, pass in type(uint256).max for sUSDAmount
    /// @param sUSDAmount Amount of sUSD debt to burn (set to type(uint256).max to burn all debt)
    /// @param snxAmount Amount of SNX to sell in order to burn sUSD debt
    /// @param exchange Exchange address to swap on
    /// @param exchangeData Calldata to call exchange with
    // SWC-111-Use of Deprecated Solidity Functions: L54
    

    /// @dev Aave flash loan callback. Receives the token amounts and gives it back + premiums.
    /// @param assets The addresses of the assets being flash-borrowed
    /// @param amounts The amounts amounts being flash-borrowed
    /// @param premiums Fees to be paid for each asset
    /// @param initiator The msg.sender to Aave
    /// @param params Arbitrary packed params to pass to the receiver as extra information
    

    /// @notice Transfer a tokens balance left on this contract to the owner
    /// @dev Can only be called by owner
    /// @param token Address of token to transfer the balance of
    // SWC-111-Use of Deprecated Solidity Functions: L122
    function transferToken(address token) external onlyOwner {
        IERC20(token).safeTransfer(msg.sender, IERC20(token).balanceOf(address(this)));
    }

    /// @dev Swap token for token
    /// @param amount Amount of token0 to swap
    /// @param exchange Exchange address to swap on
    /// @param data Calldata to call exchange with
    /// @return token1 received from swap
    function swap(
        uint256 amount,
        address exchange,
        bytes memory data
    ) internal returns (uint256) {
        snx.safeApprove(exchange, amount);
        // Security check to prevent a reentrancy attack or an attacker pulling approved tokens
        require(
            exchange != address(LENDING_POOL) && exchange != address(synthetix) && exchange != address(snx),
            "SNXFlashLoanTool: Unauthorized address"
        );
        // SWC-107-Reentrancy: L143
        (bool success, ) = exchange.call(data);
        require(success, "SNXFlashLoanTool: Swap failed");
        return sUSD.balanceOf(address(this));
    }
}
