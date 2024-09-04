pragma solidity ^0.8.0;

import "../token/FeiTimedMinter.sol";
import "../oracle/ICollateralizationOracleWrapper.sol";

/// @title CollateralizationOracleKeeper
/// @notice a FEI timed minter which only rewards when updating the collateralization oracle 
contract CollateralizationOracleKeeper is FeiTimedMinter {

    ICollateralizationOracleWrapper public collateralizationOracleWrapper;

    /**
        @notice constructor for CollateralizationOracleKeeper
        @param _core the Core address to reference
        @param _incentive the incentive amount for calling mint paid in FEI
        @param _collateralizationOracleWrapper the collateralizationOracleWrapper to incentivize updates only
        sets the target to this address and mint amount to 0, relying exclusively on the incentive payment to caller
    */
    

    function _afterMint() internal override {
        collateralizationOracleWrapper.updateIfOutdated();
    }
}