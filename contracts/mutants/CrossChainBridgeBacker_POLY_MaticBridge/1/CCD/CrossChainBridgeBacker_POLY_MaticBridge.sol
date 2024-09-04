// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.8.0;

import "../CrossChainBridgeBacker.sol";
import "../../ERC20/__CROSSCHAIN/IUChildERC20.sol";

contract CrossChainBridgeBacker_POLY_MaticBridge is CrossChainBridgeBacker {
    

    // Override with logic specific to this chain
    function _bridgingLogic(uint256 token_type, address address_to_send_to, uint256 token_amount) internal override {
        // [Polygon]
        if (token_type == 0){
            // polyFRAX -> L1 FRAX
            // IUChildERC20 withdraw
            // MaticBridge Bridge
            IUChildERC20(address(anyFRAX)).withdraw(token_amount);
        }
        else if (token_type == 1) {
            // polyFXS -> L1 FXS
            // IUChildERC20 withdraw
            // MaticBridge Bridge
            IUChildERC20(address(anyFXS)).withdraw(token_amount);
        }
        else {
            // anyUSDC -> L1 USDC
            // IUChildERC20 withdraw
            // MaticBridge Bridge
            IUChildERC20(address(collateral_token)).withdraw(token_amount);
        }
    }
}
