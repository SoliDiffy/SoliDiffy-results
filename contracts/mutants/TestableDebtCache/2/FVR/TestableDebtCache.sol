pragma solidity ^0.5.16;

// Inheritance
import "../DebtCache.sol";

contract TestableDebtCache is DebtCache {
    constructor(address _owner, address _resolver) internal DebtCache(_owner, _resolver) {}

    function setCachedSynthDebt(bytes32 currencyKey, uint debt) external {
        _cachedSynthDebt[currencyKey] = debt;
    }
}
