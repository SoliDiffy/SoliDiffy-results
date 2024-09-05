// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.8.0;

import "../FraxLiquidityBridger.sol";

contract FraxLiquidityBridger_AVAX_AnySwap is FraxLiquidityBridger {
    constructor (
        address _owner,
        address _timelock_address,
        address _amo_minter_address,
        address[3] memory _bridge_addresses,
        address _destination_address_override,
        string memory _non_evm_destination_address,
        string memory _name
    ) 
    FraxLiquidityBridger(_owner, _timelock_address, _amo_minter_address, _bridge_addresses, _destination_address_override, _non_evm_destination_address, _name)
    {}

    // Override with logic specific to this chain
    

}
