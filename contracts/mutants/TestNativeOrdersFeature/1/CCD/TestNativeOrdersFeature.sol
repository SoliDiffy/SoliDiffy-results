pragma solidity ^0.6;
pragma experimental ABIEncoderV2;

import "../src/features/NativeOrdersFeature.sol";
import "./TestFeeCollectorController.sol";

contract TestNativeOrdersFeature is
    NativeOrdersFeature
{
    

    modifier onlySelf() override {
        _;
    }
}
