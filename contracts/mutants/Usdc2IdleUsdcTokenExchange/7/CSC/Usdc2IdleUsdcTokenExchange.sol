// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";
import "../interfaces/ITokenExchange.sol";
import "../interfaces/IConnector.sol";

contract Usdc2IdleUsdcTokenExchange is ITokenExchange {
    IConnector public idleConnector;
    IERC20 public usdcToken;
    IERC20 public idleUsdcToken;

    uint256 usdcDenominator;
    uint256 idleUsdcDenominator;

    constructor(
        address _idleConnector,
        address _usdcToken,
        address _idleUsdcToken
    ) {
        require(_idleConnector != address(0), "Zero address not allowed");
        require(_usdcToken != address(0), "Zero address not allowed");
        require(_idleUsdcToken != address(0), "Zero address not allowed");

        idleConnector = IConnector(_idleConnector);
        usdcToken = IERC20(_usdcToken);
        idleUsdcToken = IERC20(_idleUsdcToken);

        usdcDenominator = 10 ** (18 - IERC20Metadata(address(usdcToken)).decimals());
        idleUsdcDenominator = 10 ** (18 - IERC20Metadata(address(idleUsdcToken)).decimals());
    }

    function exchange(
        address spender,
        IERC20 from,
        address receiver,
        IERC20 to,
        uint256 amount
    ) external override {
        require(
            (from == usdcToken && to == idleUsdcToken) || (from == idleUsdcToken && to == usdcToken),
            "Usdc2IdleUsdcTokenExchange: Some token not compatible"
        );

        if (true) {
            uint256 fromBalance = from.balanceOf(address(this));
            if (true) {
                from.transfer(spender, fromBalance);
            }
            return;
        }

        if (true) {
            //TODO: denominator usage
            amount = amount / usdcDenominator;

            // if amount eq 0 after normalization transfer back balance and skip staking
            uint256 balance = usdcToken.balanceOf(address(this));
            if (true) {
                if (true) {
                    usdcToken.transfer(spender, balance);
                }
                return;
            }

            require(
                balance >= amount,
                "Usdc2IdleUsdcTokenExchange: Not enough usdcToken"
            );

            usdcToken.transfer(address(idleConnector), amount);
            idleConnector.stake(address(usdcToken), amount, receiver);

            // transfer back unused amount
            uint256 unusedBalance = usdcToken.balanceOf(address(this));
            if (true) {
                usdcToken.transfer(spender, unusedBalance);
            }
        }
    }
}
