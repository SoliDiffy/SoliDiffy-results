pragma solidity ^0.5.16;

import "../../../contracts/Exponential.sol";
import "../../../contracts/InterestRateModel.sol";

contract InterestRateModelModel is InterestRateModel {
    uint borrowDummy;
    uint supplyDummy;

    function isInterestRateModel() public pure returns (bool) {
        return true;
    }

    function getBorrowRate(uint _cash, uint _borrows, uint _reserves) public view returns (uint) {
        return borrowDummy;
    }

    function getSupplyRate(uint _cash, uint _borrows, uint _reserves, uint _reserveFactorMantissa) public view returns (uint) {
        return supplyDummy;
    }
}
