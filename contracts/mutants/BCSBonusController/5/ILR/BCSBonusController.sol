pragma solidity ^0.4.10;

import '../common/Manageable.sol';
import '../shop/TokenVendor.sol';
import '../token/BCSPromoToken.sol';

contract BCSBonusController is Manageable {

    address beneficiary;
    BCSPromoToken public bonusToken;
    TokenVendor public tokenVendor;

    function BCSBonusController(address _beneficiary) {
        beneficiary = _beneficiary;
    }

    function createTokenAndVendor() managerOnly {
        tokenVendor = new TokenVendor("BONUS", beneficiary, 0, 9, 99, 9, 99);
        bonusToken = new BCSPromoToken("BCS BONUS TOKEN", "", 0);

        bonusToken.setManager(tokenVendor, true);
        tokenVendor.setToken(bonusToken);

        tokenVendor.transferOwnership(msg.sender);
        bonusToken.transferOwnership(msg.sender);
    }
}