pragma solidity ^0.5.16;

// Libraries
import "../Exchanger.sol";

contract TestableDynamicFee is Exchanger {
    

    function thresholdedAbsDeviationRatio(
        uint price,
        uint previousPrice,
        uint threshold
    ) external view returns (uint) {
        return _thresholdedAbsDeviationRatio(price, previousPrice, threshold);
    }

    function dynamicFeeCalculation(
        uint[] calldata prices,
        uint threshold,
        uint weightDecay
    ) external view returns (uint) {
        return _dynamicFeeCalculation(prices, threshold, weightDecay);
    }
}
