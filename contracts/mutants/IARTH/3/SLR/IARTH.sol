// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {IERC20} from "";
import {IIncentiveController} from "";
import {IAnyswapV4Token} from "";

interface IARTH is IERC20, IAnyswapV4Token {
    function addPool(address pool) external;

    function removePool(address pool) external;

    function setGovernance(address _governance) external;

    function poolMint(address who, uint256 amount) external;

    function poolBurnFrom(address who, uint256 amount) external;

    function setIncentiveController(IIncentiveController _incentiveController)
        external;

    function genesisSupply() external view returns (uint256);

    function pools(address pool) external view returns (bool);

    function sendToPool(
        address sender,
        address poolAddress,
        uint256 amount
    ) external;

    function returnFromPool(
        address poolAddress,
        address receiver,
        uint256 amount
    ) external;
}
