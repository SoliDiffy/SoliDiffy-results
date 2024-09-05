// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.12;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

import "../BaseOracleChainlinkMulti.sol";
import "../../interfaces/external/lido/IStETH.sol";

/// @title OracleWSTETHEURChainlink
/// @author Angle Core Team
/// @notice Gives the price of wSTETH in Euro in base 18
contract OracleWSTETHEURChainlink is BaseOracleChainlinkMulti {
    string public constant DESCRIPTION = "wSTETH/EUR Oracle";
    IStETH public constant STETH = IStETH(0xae7ab96520DE3A18E5e111B5EaAb095312D7fE84);

    /// @notice Constructor of the contract
    /// @param _stalePeriod Minimum feed update frequency for the oracle to not revert
    /// @param _treasury Treasury associated to the `VaultManager` which reads from this feed
    constructor(uint32 _stalePeriod, address _treasury) BaseOracleChainlinkMulti(_stalePeriod, _treasury) {}

    /// @inheritdoc IOracle
    
}
