pragma solidity ^0.5.2;
pragma experimental ABIEncoderV2; // to enable structure-type parameter

import "../perpetual/Perpetual.sol";


contract TestPerpetual is Perpetual {
    

    function addSocialLossPerContractPublic(LibTypes.Side side, int256 value) public {
        addSocialLossPerContract(side, value);
    }

    function transferCashBalancePublic(address from, address to, uint256 amount) public {
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
