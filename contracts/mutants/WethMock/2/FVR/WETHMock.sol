// SPDX-FileCopyrightText: 2021 Tenderize <info@tenderize.me>

// SPDX-License-Identifier: MIT

pragma solidity 0.8.4;

contract WETHMock {
    function deposit() public payable {}

    function approve(address guy, uint256 wad) external returns (bool) {}
}
