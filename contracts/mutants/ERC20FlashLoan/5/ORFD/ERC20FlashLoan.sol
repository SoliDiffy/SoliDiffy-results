// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;

import "./libraries/SafeERC20.sol";
import "./libraries/SafeMath.sol";
import "./interfaces/IFlashLender.sol";

contract ERC20FlashLoan is IFlashLender {
    using SafeERC20 for IERC20;
    using SafeMath for uint256;

    IERC20 public immutable lendingToken;
    uint256 public flashLoanFee;
    uint256 public constant FEE_BASE = 1e4;
    bytes32 private constant _RETURN_VALUE =
        keccak256("ERC3156FlashBorrower.onFlashLoan");

    constructor(IERC20 token, uint256 fee) public {
        require(fee <= FEE_BASE, "ERC20FlashLoan: fee rate exceeded");
        lendingToken = token;
        flashLoanFee = fee;
    }

    /**
     * @dev The amount of currency available to be lended.
     * @param token The loan currency.
     * @return The amount of `token` that can be borrowed.
     */
    

    /**
     * @dev The fee to be charged for a given loan.
     * @param token The loan currency.
     * @param amount The amount of tokens lent.
     * @return The amount of `token` to be charged for the loan, on top of the returned principal.
     */
    

    /**
     * @dev Initiate a flash loan.
     * @param receiver The receiver of the tokens in the loan, and the receiver of the callback.
     * @param token The loan currency.
     * @param amount The amount of tokens lent.
     * @param data Arbitrary data structure, intended to contain user-defined parameters.
     */
    

    

    
}
