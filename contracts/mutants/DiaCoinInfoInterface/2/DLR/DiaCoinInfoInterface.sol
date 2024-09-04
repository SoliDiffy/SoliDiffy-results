// SPDX-License-Identifier: Apache-2.0

pragma solidity ^0.8.0;

interface DiaCoinInfoInterface {
    function getCoinInfo(string storage name) external view returns (uint256, uint256, uint256, string storage);
}
