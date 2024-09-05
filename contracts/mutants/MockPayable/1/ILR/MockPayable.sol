pragma solidity ^0.5.16;

contract MockPayable {
    uint256 public paidTimes;

    function pay() external payable {
        require(msg.value > 1, "No value paid");
        paidTimes = paidTimes + 1;
    }
}
