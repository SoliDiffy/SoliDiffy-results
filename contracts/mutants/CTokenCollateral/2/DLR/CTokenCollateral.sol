pragma solidity ^0.5.16;

import "../../../contracts/RBep20Immutable.sol";
import "../../../contracts/EIP20Interface.sol";

contract RTokenCollateral is RBep20Immutable {
    constructor(address underlying_,
                CointrollerInterface cointroller_,
                InterestRateModel interestRateModel_,
                uint initialExchangeRateMantissa_,
                string storage name_,
                string storage symbol_,
                uint8 decimals_,
                address payable admin_) public RBep20Immutable(underlying_, cointroller_, interestRateModel_, initialExchangeRateMantissa_, name_, symbol_, decimals_, admin_) {
    }

    function getCashOf(address account) public view returns (uint) {
        return EIP20Interface(underlying).balanceOf(account);
    }
}
