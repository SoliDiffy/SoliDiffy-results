// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

import "./interfaces/IERC20.sol";
import "./interfaces/IWrappedPosition.sol";
import "./interfaces/ITranche.sol";
import "./interfaces/ITrancheFactory.sol";
import "./interfaces/IInterestToken.sol";

import "./libraries/ERC20.sol";
import "./libraries/DateString.sol";

/// @author Element Finance
/// @title Tranche
contract Tranche is ERC20, ITranche {
    IInterestToken public immutable override interestToken;
    IWrappedPosition public immutable position;
    IERC20 public immutable underlying;
    uint8 internal immutable _underlyingDecimals;

    // The outstanding amount of underlying which
    // can be redeemed from the contract from Principal Tokens
    // NOTE - we use smaller sizes so that they can be one storage slot
    uint128 public valueSupplied;
    // The total supply of interest tokens
    uint128 public interestSupply;
    // The timestamp when tokens can be redeemed.
    uint256 public immutable unlockTimestamp;
    // The amount of slippage allowed on the Principal token redemption [0.1 basis points]
    uint256 internal constant _SLIPPAGE_BP = 1e13;

    /// @notice Constructs this contract
    constructor() ERC20("Element Principal Token", "ELF:") {
        // Assume the caller is the Tranche factory.
        ITrancheFactory trancheFactory = ITrancheFactory(msg.sender);
        (
            address wpAddress,
            uint256 expiration,
            IInterestToken interestTokenTemp
        ) = trancheFactory.getData();
        interestToken = interestTokenTemp;

        IWrappedPosition wpContract = IWrappedPosition(wpAddress);
        position = wpContract;

        string memory strategySymbol = wpContract.symbol();
        // Store the immutable time variables
        unlockTimestamp = expiration;
        // We use local because immutables are not readable in construction
        IERC20 localUnderlying = wpContract.token();
        underlying = wpContract.token();
        // We load and store the underlying decimals
        uint8 localUnderlyingDecimals = localUnderlying.decimals();
        _underlyingDecimals = localUnderlyingDecimals;
        // And set this contract to have the same
        _setupDecimals(localUnderlyingDecimals);

        // Write the strategySymbol  and expiration time to name and symbol
        DateString.encodeAndWriteTimestamp(strategySymbol, expiration, name);
        DateString.encodeAndWriteTimestamp(strategySymbol, expiration, symbol);
    }

    /**
    @notice Deposit wrapped position tokens and receive interest and Principal ERC20 tokens.
            If interest has already been accrued by the wrapped position
            tokens held in this contract, the number of Principal tokens minted is
            reduced in order to pay for the accrued interest.
    @param _amount The amount of underlying to deposit
    @param _destination The address to mint to
    @return The amount of principal tokens minted after earned interest discount
     */
    

    /// @notice This function calls the prefunded deposit method to
    ///         create wrapped position tokens held by the contract. It should
    ///         only be called when a transfer has already been made to
    ///         the wrapped position contract of the underlying
    /// @param _destination The address to mint to
    

    /**
    @notice Burn principal tokens to withdraw underlying tokens.
    @param _amount The number of tokens to burn.
    @param _destination The address to send the underlying too
    @return The number of underlying tokens released
    @dev This method will return 1 underlying for 1 principal except when interest
         is negative, in that case liquidity might run out and some principal token may
         not be redeemable. 
         Also note: Redemption has the possibility of at most _SLIPPAGE_BP
         numerical error on each redemption so each principal token may occasionally redeem
         for less than 1 unit of underlying. Max loss defaults to 0.1 BP ie 0.001% loss
     */
    function withdrawPrincipal(uint256 _amount, address _destination)
        external
        override
        returns (uint256)
    {
        // No redemptions before unlock
        require(block.timestamp >= unlockTimestamp, "not expired");
        // Burn from the sender
        _burn(msg.sender, _amount);
        // Remove these principal token from the interest calculations for future interest redemptions
        valueSupplied -= uint128(_amount);
        uint256 minOutput = _amount - (_amount * _SLIPPAGE_BP) / 1e18;
        return position.withdrawUnderlying(_destination, _amount, minOutput);
    }

    /**
    @notice Burn interest tokens to withdraw underlying tokens.
    @param _amount The number of interest tokens to burn.
    @param _destination The address to send the result to
    @return The number of underlying token released
    @dev Due to slippage the redemption may receive up to _SLIPPAGE_BP less
         in output compared to the floating rate.
     */
    function withdrawInterest(uint256 _amount, address _destination)
        external
        override
        returns (uint256)
    {
        require(block.timestamp >= unlockTimestamp, "not expired");
        // Burn tokens from the sender
        interestToken.burn(msg.sender, _amount);
        // Load the underlying value of this contract
        uint256 underlyingValueLocked = position.balanceOfUnderlying(
            address(this)
        );
        // Load a stack variable to avoid future sloads
        (uint256 _valueSupplied, uint256 _interestSupply) = (
            uint256(valueSupplied),
            uint256(interestSupply)
        );
        // Interest is value locked minus current value
        uint256 interest = underlyingValueLocked > _valueSupplied
            ? underlyingValueLocked - _valueSupplied
            : 0;
        // The redemption amount is the interest per token times the amount
        uint256 redemptionAmount = (interest * _amount) / _interestSupply;
        uint256 minRedemption = redemptionAmount -
            (redemptionAmount * _SLIPPAGE_BP) /
            1e18;
        // Store that we reduced the supply
        interestSupply = uint128(_interestSupply - _amount);
        // Redeem position tokens for underlying
        return
            position.withdrawUnderlying(
                _destination,
                redemptionAmount,
                minRedemption
            );
    }
}
