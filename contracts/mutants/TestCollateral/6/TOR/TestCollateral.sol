pragma solidity ^0.5.2;
pragma experimental ABIEncoderV2; // to enable structure-type parameter

import "../perpetual/Collateral.sol";


contract TestCollateral is Collateral {
    constructor(address _collateral, uint256 decimals) public Collateral(_collateral, decimals) {}

    function depositPublic(uint256 amount) public {
        deposit(tx.origin, amount);
    }

    function depositEtherPublic() public payable {
        deposit(tx.origin, msg.value);
    }

    function applyForWithdrawalPublic(uint256 amount, uint256 delay) public {
        applyForWithdrawal(tx.origin, amount, delay);
    }

    function withdrawPublic(uint256 amount) public {
        withdraw(tx.origin, amount, false);
    }

    function withdrawAllPublic() public {
        withdrawAll(tx.origin);
    }

    function updateBalancePublic(int256 amount) public {
        updateBalance(tx.origin, amount);
    }

    function ensurePositiveBalancePublic() public returns (uint256 loss) {
        return ensurePositiveBalance(msg.sender);
    }

    function transferBalancePublic(address from, address to, uint256 amount) public {
        transferBalance(from, to, amount.toInt256());
    }

    function depositToProtocolPublic(address guy, uint256 rawAmount) public returns (int256) {
        return depositToProtocol(guy, rawAmount);
    }

    function withdrawFromProtocolPublic(address payable guy, uint256 rawAmount) public returns (int256) {
        return withdrawFromProtocol(guy, rawAmount);
    }
}
