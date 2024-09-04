// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.8.0;

import "../CrossChainBridgeBacker.sol";
import "../../ERC20/__CROSSCHAIN/IAnyswapV5ERC20.sol";
import "./IL2GatewayRouter.sol";

contract CrossChainBridgeBacker_ARBI_AnySwap is CrossChainBridgeBacker {
    

    // Override with logic specific to this chain
    function _bridgingLogic(uint256 token_type, address address_to_send_to, uint256 token_amount) internal override {
        // [Arbitrum]
        if (token_type == 0){
            // anyFRAX -> L1 FRAX
            // Swapout
            // AnySwap Bridge
            IAnyswapV5ERC20(address(anyFRAX)).Swapout(token_amount, address_to_send_to);
        }
        else if (token_type == 1) {
            // anyFXS -> L1 FXS
            // Swapout
            // AnySwap Bridge
            IAnyswapV5ERC20(address(anyFXS)).Swapout(token_amount, address_to_send_to);
        }
        else {
            revert("COLLATERAL TRANSFERS ARE DISABLED FOR NOW");
            // // arbiUSDC => L1 USDC
            // // outboundTransfer
            // // Arbitrum One Bridge
            // // https://arbiscan.io/tx/0x32e16d596084d55f5ea0411ecfa25354e951db4b0d0055a14a86caeeb5d8f133

            // revert("MAKE SURE TO TEST THIS CAREFULLY BEFORE DEPLOYING");

            // // Approve
            // collateral_token.approve(bridge_addresses[token_type], token_amount);

            // // Get the calldata
            // uint256 maxSubmissionCost = 1;
            // bytes memory the_calldata = abi.encode(['uint256', 'bytes'], maxSubmissionCost, '0x');

            // // Transfer
            // IL2GatewayRouter(bridge_addresses[token_type]).outboundTransfer(
            //     0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48, // L1 token address
            //     address_to_send_to,
            //     token_amount,
            //     the_calldata
            // );
        }
    }
}
