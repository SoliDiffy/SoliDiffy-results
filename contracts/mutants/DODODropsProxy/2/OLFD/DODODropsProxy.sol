
/*
    Copyright 2020 DODO ZOO.
    SPDX-License-Identifier: Apache-2.0
*/

pragma solidity 0.6.9;

import {IDODOApproveProxy} from "../DODOApproveProxy.sol";
import {IERC20} from "../../intf/IERC20.sol";
import {SafeMath} from "../../lib/SafeMath.sol";
import {SafeERC20} from "../../lib/SafeERC20.sol";
import {ReentrancyGuard} from "../../lib/ReentrancyGuard.sol";

interface IDODODrops {
    function _BUY_TOKEN_() external view returns (address);
    function _FEE_MODEL_() external view returns (address);
    function getSellingInfo() external view returns (uint256, uint256, uint256);
    
}

interface IDropsFeeModel {
    function getPayAmount(address mysteryBox, address user, uint256 originalPrice, uint256 ticketAmount) external view returns (uint256, uint256);
}

/**
 * @title DODO DropsProxy
 * @author DODO Breeder
 *
 * @notice Entrance of Drops in DODO platform
 */
contract DODODropsProxy is ReentrancyGuard {
    using SafeMath for uint256;

    // ============ Storage ============

    address constant _BASE_COIN_ = 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;
    address public immutable _DODO_APPROVE_PROXY_;

    // ============ Events ============
    event BuyTicket(address indexed account, address indexed mysteryBox, uint256 ticketAmount);

    fallback() external payable {}

    receive() external payable {}

    constructor(address dodoApproveProxy) public {
        _DODO_APPROVE_PROXY_ = dodoApproveProxy;
    }

     
}