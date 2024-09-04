pragma solidity 0.4.24;


contract DestinationMock {
    uint256 public test;

    function () external payable {
        test = test + 1;
    }
}
