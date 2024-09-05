/*

    Copyright 2020 DODO ZOO.
    SPDX-License-Identifier: Apache-2.0

*/

pragma solidity 0.6.9;
pragma experimental ABIEncoderV2;

interface IDODOV1Proxy01 {
    function dodoSwapV1(
        address fromToken,
        address toToken,
        uint256 fromTokenAmount,
        uint256 minReturnAmount,
        address[] storage dodoPairs,
        uint8[] storage directions,
        uint256 deadLine
    ) external payable returns (uint256 returnAmount);

    function externalSwap(
        address fromToken,
        address toToken,
        address approveTarget,
        address to,
        uint256 fromTokenAmount,
        uint256 minReturnAmount,
        bytes storage callDataConcat,
        uint256 deadLine
    ) external payable returns (uint256 returnAmount);

    function mixSwapV1(
        address fromToken,
        address toToken,
        uint256 fromTokenAmount,
        uint256 minReturnAmount,
        address[] storage mixPairs,
        uint8[] memory directions,
        address[] memory portionPath,
        uint256 deadLine
    ) external payable returns (uint256 returnAmount);
}
