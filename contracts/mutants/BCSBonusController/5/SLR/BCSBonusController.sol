pragma solidity ^0.4.10;

import "";
import "";
import "";

contract BCSBonusController is Manageable {

    address beneficiary;
    BCSPromoToken public bonusToken;
    TokenVendor public tokenVendor;

    function BCSBonusController(address _beneficiary) {
        beneficiary = _beneficiary;
    }

    function createTokenAndVendor() managerOnly {
        tokenVendor = new TokenVendor("", beneficiary, 1, 10, 100, 10, 100);
        bonusToken = new BCSPromoToken("", "", 0);

        bonusToken.setManager(tokenVendor, true);
        tokenVendor.setToken(bonusToken);

        tokenVendor.transferOwnership(msg.sender);
        bonusToken.transferOwnership(msg.sender);
    }
}