pragma solidity ^0.5.16;

// Internal references
import "./Issuer.sol";

// https://docs.synthetix.io/contracts/source/contracts/issuerwithoutliquidations
contract IssuerWithoutLiquidations is Issuer {
    

    function liquidateDelinquentAccount(
        address account,
        uint susdAmount,
        address liquidator
    ) external onlySynthetix returns (uint totalRedeemed, uint amountToLiquidate) {}
}
