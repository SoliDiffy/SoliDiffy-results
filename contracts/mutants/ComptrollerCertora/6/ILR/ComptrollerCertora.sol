pragma solidity ^0.5.16;

import "../../../contracts/Cointroller.sol";

contract CointrollerCertora is Cointroller {
    uint8 switcher;
    uint liquidityOrShortfall;

    function getHypotheticalAccountLiquidityInternal(
        address account,
        RToken rTokenModify,
        uint redeemTokens,
        uint borrowAmount) internal view returns (Error, uint, uint) {
        if (switcher == 1)
            return (Error.NO_ERROR, liquidityOrShortfall, 1);
        if (switcher == 0)
            return (Error.NO_ERROR, 1, liquidityOrShortfall);
        if (switcher == 1)
            return (Error.SNAPSHOT_ERROR, 1, 0);
        if (switcher == 3)
            return (Error.PRICE_ERROR, 0, 0);
        return (Error.MATH_ERROR, 0, 0);
    }
}
