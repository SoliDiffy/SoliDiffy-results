// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.12;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

import "../BaseOracleChainlinkMulti.sol";

/// @title OracleBTCEURChainlink
/// @author Angle Core Team
/// @notice Gives the price of BTC in Euro in base 18
contract OracleBTCEURChainlink is BaseOracleChainlinkMulti {
    uint256 public constant OUTBASE = 10**18;
    string public constant DESCRIPTION = "BTC/EUR Oracle";

    /// @notice Constructor of the contract
    /// @param _stalePeriod Minimum feed update frequency for the oracle to not revert
    /// @param _treasury Treasury associated to the `VaultManager` which reads from this feed
    constructor(uint32 _stalePeriod, address _treasury) BaseOracleChainlinkMulti(_stalePeriod, _treasury) {}

    /// @inheritdoc IOracle
    
}
