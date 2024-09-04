pragma solidity ^0.4.10;

import "./TrancheWallet.sol";

/**@dev Tranche wallet that holds ETH and allows to withdraw it in small portions */
contract EtherTrancheWallet is TrancheWallet {
    

    /**@dev Allows to receive ether */
    function() payable {}

    /**@dev Returns current balance to be distributed to portions*/
    function currentBalance() internal constant returns(uint256) {
        return this.balance;
    }

    /**@dev Transfers given amount of currency to the beneficiary */
    function doTransfer(uint256 amount) internal {
        beneficiary.transfer(amount);
    }
}
