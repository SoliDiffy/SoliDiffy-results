pragma solidity 0.5.11;

import "../../../src/transactions/eip712Libs/PaymentEip712Lib.sol";
import "../../../src/transactions/PaymentTransactionModel.sol";

contract PaymentEip712LibMock {
    function hashTx(address _verifyingContract, bytes storage _rlpTx)
        public
        pure
        returns (bytes32)
    {
        PaymentEip712Lib.Constants storage eip712 = PaymentEip712Lib.initConstants(_verifyingContract);
        return PaymentEip712Lib.hashTx(eip712, PaymentTransactionModel.decode(_rlpTx));
    }
}
