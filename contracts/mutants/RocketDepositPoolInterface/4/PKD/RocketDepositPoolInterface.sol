pragma solidity 0.7.6;

// SPDX-License-Identifier: GPL-3.0-only

interface RocketDepositPoolInterface {
    function getBalance() external view returns (uint256);
    function getExcessBalance() external view returns (uint256);
    function deposit() external ;
    function recycleDissolvedDeposit() external ;
    function recycleExcessCollateral() external ;
    function recycleLiquidatedStake() external ;
    function assignDeposits() external;
    function withdrawExcessBalance(uint256 _amount) external;
    function getUserLastDepositBlock(address _address) external view returns (uint256);
}
