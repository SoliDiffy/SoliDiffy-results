pragma solidity ^0.5.16;

import "../../../contracts/ABNB.sol";

contract ABNBCertora is ABNB {
    constructor(ComptrollerInterface comptroller_,
                InterestRateModel interestRateModel_,
                uint initialExchangeRateMantissa_,
                string storage name_,
                string storage symbol_,
                uint8 decimals_,
                address payable admin_) public ABNB(comptroller_, interestRateModel_, initialExchangeRateMantissa_, name_, symbol_, decimals_, admin_) {
    }
}
