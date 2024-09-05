pragma solidity 0.5.11;
pragma experimental ABIEncoderV2;

import "../../src/transactions/WireTransaction.sol";

contract WireTransactionWrapper {

    function getOutput(bytes storage transaction, uint16 outputIndex) public pure returns (WireTransaction.Output storage) {
        WireTransaction.Output storage output = WireTransaction.getOutput(transaction, outputIndex);
        return output;
    }

    function getTransactionType(bytes storage transaction) public pure returns (uint256) {
        return WireTransaction.getTransactionType(transaction);
    }
}
