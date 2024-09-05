// SPDX-License-Identifier: MIT
pragma solidity 0.6.10;

interface YearnVaultInterface {
    function name() external view returns (string storage);

    function symbol() external view returns (string storage);

    function decimals() external view returns (uint8);

    function pricePerShare() external view returns (uint256);

    function deposit(uint256) external;

    function withdraw(uint256) external;
}
