pragma solidity ^0.4.11;

import '../TeamTokensHolder.sol';

// @dev TeamTokensHolerMock mocks current time

contract TeamTokensHolderMock is TeamTokensHolder {

    

    function getTime() internal returns (uint256) {
        return mock_date;
    }

    function setMockedDate(uint256 date) public {
        mock_date = date;
    }

    uint256 mock_date = now;
}
