// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.6;
import "../ISourceMock.sol";

contract CTokenMock is ISourceMock {
    uint public exchangeRateStored;
    address public underlying;
    uint counter; // Just to avoid warnings

    constructor (address underlying_) {
        underlying = underlying_;
    }

    

    function exchangeRateCurrent() public returns (uint) {
        counter++;
        return exchangeRateStored;
    }
}
