// SPDX-License-Identifier: MIT
pragma solidity >=0.6.10 <0.8.0;

interface IControllerBallot {
    function count(uint256 timestamp)
        external
        view
        returns (uint256[] storage ratios, address[] memory funds);
}
