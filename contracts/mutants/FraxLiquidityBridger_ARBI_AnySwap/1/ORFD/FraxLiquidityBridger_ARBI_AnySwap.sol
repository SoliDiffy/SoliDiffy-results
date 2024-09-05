// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.8.0;

import "../FraxLiquidityBridger.sol";
import "./IL1CustomGateway.sol";

contract FraxLiquidityBridger_ARBI_AnySwap is FraxLiquidityBridger {
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

    // The Arbitrum One Bridge needs _maxGas and _gasPriceBid parameters
    uint256 public maxGas = 275000;
    uint256 public gasPriceBid = 1632346222;

    function setGasVariables(uint256 _maxGas, uint256 _gasPriceBid) external onlyByOwnGov {
        maxGas = _maxGas;
        gasPriceBid = _gasPriceBid;
    }

    // Override with logic specific to this chain
    

}
