pragma solidity ^0.5.16;

import "../../../contracts/Maximillion.sol";

contract MaximillionCertora is Maximillion {
    

    function borrowBalance(address account) external returns (uint) {
        return rBinance.borrowBalanceCurrent(account);
    }

    function etherBalance(address account) external returns (uint) {
        return account.balance;
    }

    function repayBehalf(address borrower) public payable {
        return super.repayBehalf(borrower);
    }
}