// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.8.0;

import "../FraxLiquidityBridger.sol";

contract FraxLiquidityBridger_FTM_AnySwap is FraxLiquidityBridger {
    

    // Override with logic specific to this chain
    function _bridgingLogic(uint256 token_type, address address_to_send_to, uint256 token_amount) internal override {
        // [Fantom]
        if (token_type == 0){
            // L1 FRAX -> anyFRAX
            // Simple dump in / CREATE2
            // AnySwap Bridge
            TransferHelper.safeTransfer(address(FRAX), bridge_addresses[token_type], token_amount);
        }
        else if (token_type == 1) {
            // L1 FXS -> anyFXS
            // Simple dump in / CREATE2
            // AnySwap Bridge
            TransferHelper.safeTransfer(address(FXS), bridge_addresses[token_type], token_amount);
        }
        else {
            // L1 USDC -> anyUSDC
            // Simple dump in / CREATE2
            // AnySwap Bridge
            TransferHelper.safeTransfer(collateral_address, bridge_addresses[token_type], token_amount);
        }
    }

}
