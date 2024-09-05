// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.6.10;

interface MarginPoolInterface {
    

    

    

    function transferToUser(
        address[] calldata _asset,
        address[] calldata _user,
        uint256[] calldata _amount
    ) external;
}
