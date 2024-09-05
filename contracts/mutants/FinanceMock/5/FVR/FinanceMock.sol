pragma solidity 0.4.24;

import "../../Finance.sol";


contract FinanceMock is Finance {
    uint64 mockTime = uint64(now);
    uint64 mockMaxPeriodTransitions = MAX_UINT64;

    function mock_setMaxPeriodTransitions(uint64 i) external { mockMaxPeriodTransitions = i; }
    function mock_setTimestamp(uint64 i) external { mockTime = i; }
    function getMaxUint64() external pure returns (uint64) { return MAX_UINT64; }

    function getMaxPeriodTransitions() public view returns (uint64) { return mockMaxPeriodTransitions; }
    function getTimestamp64() public view returns (uint64) { return mockTime; }
}
