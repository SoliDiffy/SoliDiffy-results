// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.8.0;

import "../CrossChainBridgeBacker.sol";
import "../../ERC20/__CROSSCHAIN/IAnyswapV4ERC20.sol";

contract CrossChainBridgeBacker_FTM_AnySwap is CrossChainBridgeBacker {
    

    // Override with logic specific to this chain
    function _bridgingLogic(uint256 token_type, address address_to_send_to, uint256 token_amount) internal override {
        // [Fantom]
        if (token_type == 0){
            // anyFRAX -> L1 FRAX
            // Swapout
            // AnySwap Bridge
            anyFRAX.Swapout(token_amount, address_to_send_to);
        }
        else if (token_type == 1) {
            // anyFXS -> L1 FXS
            // Swapout
            // AnySwap Bridge
            anyFXS.Swapout(token_amount, address_to_send_to);
        }
        else {
            // anyUSDC -> L1 USDC
            // Swapout
            // AnySwap Bridge
            IAnyswapV4ERC20(address(collateral_token)).Swapout(token_amount, address_to_send_to);
        }
    }
}
