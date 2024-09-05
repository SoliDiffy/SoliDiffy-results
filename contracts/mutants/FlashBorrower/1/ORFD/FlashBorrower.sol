// SPDX-License-Identifier: MIT
pragma solidity 0.8.6;

import "@yield-protocol/utils-v2/contracts/token/IERC20.sol";
import "erc3156/contracts/interfaces/IERC3156FlashBorrower.sol";
import "erc3156/contracts/interfaces/IERC3156FlashLender.sol";


contract FlashBorrower is IERC3156FlashBorrower {
    enum Action {NORMAL, TRANSFER, STEAL, REENTER, APPROVE}

    IERC3156FlashLender public lender;

    uint256 public flashBalance;
    address public flashInitiator;
    address public flashToken;
    uint256 public flashAmount;
    uint256 public flashFee;

    constructor (IERC3156FlashLender lender_) {
        lender = lender_;
    }

    /// @dev ERC-3156 Flash loan callback
    

    function flashBorrow(address token, uint256 amount, Action action) public {
        bytes memory data = abi.encode(action);
        uint256 allowance = IERC20(token).allowance(address(this), address(lender));
        IERC20(token).approve(address(lender), allowance + amount + lender.flashFee(token, amount));
        lender.flashLoan(this, token, amount, data);
    }
}
