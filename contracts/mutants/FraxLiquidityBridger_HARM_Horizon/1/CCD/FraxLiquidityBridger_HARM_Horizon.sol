// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.8.0;

import "../FraxLiquidityBridger.sol";
import "../../Misc_AMOs/harmony/IERC20EthManager.sol";

contract FraxLiquidityBridger_HARM_Horizon is FraxLiquidityBridger {
    

    // Override with logic specific to this chain
    function _bridgingLogic(uint256 token_type, address address_to_send_to, uint256 token_amount) internal override {
        // [Harmony]
        if (token_type == 0){
            // L1 FRAX -> 1FRAX
            // Horizon Bridge
            // Approve
            ERC20(address(FRAX)).approve(bridge_addresses[token_type], token_amount);

            // lockToken
            IERC20EthManager(bridge_addresses[token_type]).lockToken(address(FRAX), token_amount, address_to_send_to);
        }
        else if (token_type == 1) {
            // L1 FXS -> 1FXS
            // Horizon Bridge
            // Approve
            ERC20(address(FXS)).approve(bridge_addresses[token_type], token_amount);

            // lockToken
            IERC20EthManager(bridge_addresses[token_type]).lockToken(address(FXS), token_amount, address_to_send_to);
        }
        else {
            // L1 USDC -> 1USDC
            // Horizon Bridge
            // Approve
            ERC20(collateral_address).approve(bridge_addresses[token_type], token_amount);

            // lockToken
            IERC20EthManager(bridge_addresses[token_type]).lockToken(collateral_address, token_amount, address_to_send_to);
        }
    }

}
