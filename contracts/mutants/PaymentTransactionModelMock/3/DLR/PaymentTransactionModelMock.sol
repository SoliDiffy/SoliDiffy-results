pragma solidity 0.5.11;
pragma experimental ABIEncoderV2;

import "../../src/transactions/PaymentTransactionModel.sol";

contract PaymentTransactionModelMock {

    function decode(bytes storage _transaction) public pure returns (PaymentTransactionModel.Transaction storage) {
        PaymentTransactionModel.Transaction storage transaction = PaymentTransactionModel.decode(_transaction);
        return transaction;
    }

}
