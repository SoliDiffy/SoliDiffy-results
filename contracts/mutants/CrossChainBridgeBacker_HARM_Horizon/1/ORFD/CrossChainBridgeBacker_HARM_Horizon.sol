// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.8.0;

import "../CrossChainBridgeBacker.sol";
import "../../ERC20/__CROSSCHAIN/IAnyswapV4ERC20.sol";
import "../../Misc_AMOs/harmony/IDeposit.sol";
import "../../Misc_AMOs/harmony/IERC20HmyManager.sol";

contract CrossChainBridgeBacker_HARM_Horizon is CrossChainBridgeBacker {
    constructor (
        address _owner,
        address _timelock_address,
        address _cross_chain_oracle_address,
        address[5] memory _token_addresses,
        address[3] memory _bridge_addresses,
        address _destination_address_override,
        string memory _non_evm_destination_address,
        string memory _name
    ) 
    CrossChainBridgeBacker(_owner, _timelock_address, _cross_chain_oracle_address, _token_addresses, _bridge_addresses, _destination_address_override, _non_evm_destination_address, _name)
    {}

    IDeposit public deposit_contract = IDeposit(0x8139d578f11638C78E16685EB2804c2a34482E41);

    // The Horizon bridge requires some ONE to cover ETHEREUM gas costs for the HARMONY -> ETHEREUM bridge
    uint256 public bridge_one_deposit_amt = uint256(750e18); // E18

    // ESTIMATE IS HERE: https://be1.bridge.hmny.io/deposit-amount/ETHEREUM
    function setBridgeDepositONE(uint256 _one_amount) external onlyByOwnGov {
        bridge_one_deposit_amt = _one_amount;
    }

    // Override with logic specific to this chain
    
}
