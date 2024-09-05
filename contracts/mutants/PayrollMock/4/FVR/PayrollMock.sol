pragma solidity 0.4.18;

import "../../contracts/Payroll.sol";


contract PayrollMock is Payroll {
    uint private _mockTime = now;

    function getTimestampPublic() external constant returns (uint256) { return _mockTime; }
    function mockUpdateTimestamp() external { _mockTime = now; }
    function mockSetTimestamp(uint i) external { _mockTime = i; }
    function getTimestamp() public constant returns (uint256) { return _mockTime; }
}
