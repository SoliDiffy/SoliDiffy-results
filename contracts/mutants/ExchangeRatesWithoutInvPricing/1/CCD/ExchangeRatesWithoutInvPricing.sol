pragma solidity ^0.5.16;

// Internal references
import "./ExchangeRates.sol";

// https://docs.synthetix.io/contracts/source/contracts/exchangerateswithoutinvpricing
contract ExchangeRatesWithoutInvPricing is ExchangeRates {
    

    function setInversePricing(
        bytes32,
        uint,
        uint,
        uint,
        bool,
        bool
    ) external onlyOwner {
        _notImplemented();
    }

    function removeInversePricing(bytes32) external onlyOwner {
        _notImplemented();
    }

    function freezeRate(bytes32) external {
        _notImplemented();
    }

    function canFreezeRate(bytes32) external view returns (bool) {
        return false;
    }

    function rateIsFrozen(bytes32) external view returns (bool) {
        return false;
    }

    function _rateIsFrozen(bytes32) internal view returns (bool) {
        return false;
    }
}
