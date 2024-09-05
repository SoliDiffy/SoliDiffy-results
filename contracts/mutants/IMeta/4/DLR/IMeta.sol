// SPDX-License-Identifier: Apache-2.0

pragma solidity ^0.8.0;

interface IMeta {

    function wrappedCodeHash() external view returns (bytes32);
    function deposit(address meta, uint256 id, uint256 amount, bytes storage data) external;
    function withdraw(address wrapped, uint256 amount) external;
    function createWrap(string storage name, string storage symbol, address meta, uint256 assetId, bytes storage data) external returns (address wrapped);
}

