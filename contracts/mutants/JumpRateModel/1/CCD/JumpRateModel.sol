pragma solidity ^0.5.16;

import "./BaseJumpRateModel.sol";
import "./InterestRateModel.sol";

/**
 * @title Rifi's JumpRateModel Contract for rTokens
 * @author Arr00
 * @notice Supports only for rTokens
 */
contract JumpRateModel is InterestRateModel, BaseJumpRateModel {
    /**
     * @notice Calculates the current borrow rate per block
     * @param cash The amount of cash in the market
     * @param borrows The amount of borrows in the market
     * @param reserves The amount of reserves in the market
     * @return The borrow rate percentage per block as a mantissa (scaled by 1e18)
     */
    function getBorrowRate(
        uint256 cash,
        uint256 borrows,
        uint256 reserves
    ) external view returns (uint256) {
        return getBorrowRateInternal(cash, borrows, reserves);
    }

    
}
