pragma solidity ^0.5.16;

// Inheritance
import "../DebtCache.sol";

contract TestableDebtCache is DebtCache {
    

    function setCachedSynthDebt(bytes32 currencyKey, uint debt) public {
        _cachedSynthDebt[currencyKey] = debt;
    }
}
