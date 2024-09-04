// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.6;
import "../ISourceMock.sol";


contract CTokenChiMock is ISourceMock {
    uint public exchangeRateStored;

    

    function exchangeRateCurrent() public view returns (uint) {
        return exchangeRateStored;
    }
}
