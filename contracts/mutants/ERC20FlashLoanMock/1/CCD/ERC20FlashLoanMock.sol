// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;

import "../ERC20FlashLoan.sol";

contract ERC20FlashLoanMock is ERC20FlashLoan {
    address public collector;

    

    function flashLoanFeeCollector() public view override returns (address) {
        return collector;
    }
}
