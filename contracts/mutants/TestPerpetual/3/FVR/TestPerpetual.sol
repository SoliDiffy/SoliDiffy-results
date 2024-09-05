pragma solidity ^0.5.2;
pragma experimental ABIEncoderV2; // to enable structure-type parameter

import "../perpetual/Perpetual.sol";


contract TestPerpetual is Perpetual {
    constructor(address _globalConfig, address _devAddress, address collateral, uint256 collateralDecimals)
        internal
        Perpetual(_globalConfig, _devAddress, collateral, collateralDecimals)
    {}

    function addSocialLossPerContractPublic(LibTypes.Side side, int256 value) external {
        addSocialLossPerContract(side, value);
    }

    function transferCashBalancePublic(address from, address to, uint256 amount) external {
        transferCashBalance(from, to, amount);
    }

    function forceSetCollateral(address guy, LibTypes.CollateralAccount memory value) public {
        cashBalances[guy] = value;
    }

    function forceSetPosition(address guy, LibTypes.PositionAccount memory value) public {
        positions[guy] = value;
    }

    function forceSetTotalSize(uint256 value) public {
        totalSizes[1] = value;
        totalSizes[2] = value;
    }
}
