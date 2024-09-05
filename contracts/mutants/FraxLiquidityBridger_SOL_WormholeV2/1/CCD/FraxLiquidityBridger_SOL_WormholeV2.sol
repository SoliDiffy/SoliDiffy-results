// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.8.0;

import "../FraxLiquidityBridger.sol";
import "../../Misc_AMOs/solana/IBridgeImplementation.sol";

contract FraxLiquidityBridger_SOL_WormholeV2 is FraxLiquidityBridger {
    

    // The Horizon bridge requires some ONE to cover ETHEREUM gas costs for the HARMONY -> ETHEREUM bridge
    bytes32[3] public base58_decoded_recipients;

    function setBase58DecodedRecipients(bytes32[3] memory _base58_decoded_recipients) external onlyByOwnGov {
        base58_decoded_recipients = _base58_decoded_recipients;
    }

    function randomNonce() public view returns(uint32) {
        uint256 seed = uint256(keccak256(abi.encodePacked(
            block.timestamp + block.difficulty +
            ((uint256(keccak256(abi.encodePacked(block.coinbase)))) / (block.timestamp)) +
            block.gaslimit + 
            ((uint256(keccak256(abi.encodePacked(msg.sender)))) / (block.timestamp)) +
            block.number
        )));

        return uint32(seed - ((seed / 9999999999) * 9999999999));
    }

    // Override with logic specific to this chain
    // NOTE [FOR SOLANA]: After transferring, you have to go here https://wormholebridge.com/#/transfer
    // and manually submit the transaction to be processed
    function _bridgingLogic(uint256 token_type, address address_to_send_to, uint256 token_amount) internal override {
        // [Solana]
        // Bridge V2 is 0x3ee18B2214AFF97000D974cf647E7C347E8fa585
        // https://etherscan.io/tx/0xab7e1f1c234ff4305a00dd3b29338c1b9287ac98e4fabc9e5417c1dbbcedc11b

        address bridgeable_token_address;
        if (token_type == 0){
            // L1 FRAX -> polyFRAX
            // Polygon Bridge
            bridgeable_token_address = address(FRAX);
        }
        else if (token_type == 1) {
            // L1 FXS -> polyFXS
            // Polygon Bridge
            bridgeable_token_address = address(FXS);
        }
        else {
            // L1 USDC -> polyUSDC
            // Polygon Bridge
            bridgeable_token_address = collateral_address;
        }

        // Approve first
        ERC20(bridgeable_token_address).approve(bridge_addresses[token_type], token_amount);

        // 1) Take the destination token account address (NOT the wallet account address). You can see it here https://solanabeach.io/address/<WALLET ADDRESS HERE>/tokens?display=advanced
        // 2) Go here and decode https://www.appdevtools.com/base58-encoder-decoder. Treat output as hex
        // 3) Prepend "0x"
        // 4) Result is what _non_evm_destination_address should be
        // 5) Example: 8j9SUvwDE4gXjgJuooVNcNB5aZV3w7JiL6YALa5CYF1U's wFRAX_V2 token account address is FVsEDz8aesnfX6i4jAY1m738uPZzmLWhCQkyZwfToydY
        // Base58 decode is d768ac2f9a0a3af6f63af0c7a46f0de5fa43ed47c3d347fa4d3e36b791565037. Prepend 0x, so 0xd768ac2f9a0a3af6f63af0c7a46f0de5fa43ed47c3d347fa4d3e36b791565037
        // Alternatively, manually set the recipient decoded base58 hex

        // Make sure to do recovery manually after 15 confirmations
        // https://wormholebridge.com/#/transfer
        IBridgeImplementation(bridge_addresses[token_type]).transferTokens(
            bridgeable_token_address,
            token_amount,
            1,
            base58_decoded_recipients[token_type],
            0,
            randomNonce()
        );
    }
}
