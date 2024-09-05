pragma solidity ^0.4.11;

import '../ReserveTokensHolder.sol';

// @dev ReserveTokensHolderMock mocks current time

contract ReserveTokensHolderMock is ReserveTokensHolder {

    

    function getTime() internal returns (uint256) {
        return mock_date;
    }

    function setMockedDate(uint256 date) public {
        mock_date = date;
    }

    uint256 mock_date = now;
}
