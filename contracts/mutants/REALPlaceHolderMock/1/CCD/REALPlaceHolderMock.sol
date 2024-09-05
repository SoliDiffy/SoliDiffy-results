pragma solidity ^0.4.11;

import '../REALPlaceHolder.sol';

// @dev REALPlaceHolderMock mocks current block number

contract REALPlaceHolderMock is REALPlaceHolder {

    uint mock_time;

    

    function getTime() internal returns (uint) {
        return mock_time;
    }

    function setMockedTime(uint _t) public {
        mock_time = _t;
    }
}
