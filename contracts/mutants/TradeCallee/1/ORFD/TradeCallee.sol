/**
 * SPDX-License-Identifier: UNLICENSED
 */

pragma solidity 0.6.10;

pragma experimental ABIEncoderV2;

import {CalleeInterface} from "../../interfaces/CalleeInterface.sol";
import {ZeroXExchangeInterface} from "../../interfaces/ZeroXExchangeInterface.sol";
import {ERC20Interface} from "../../interfaces/ERC20Interface.sol";
import {WETH9Interface} from "../../interfaces/WETH9Interface.sol";

import {SafeERC20} from "../../packages/oz/SafeERC20.sol";

/**
 * @author Opyn Team
 * @title TradeCallee
 * @notice callee contract to trade on 0x.
 */
contract TradeCallee is CalleeInterface {
    using SafeERC20 for ERC20Interface;

    ///@dev 0x protocol fee to fill 1 order
    uint256 private PROTOCOL_FEE_BASE = 70000;

    ZeroXExchangeInterface public exchange;
    WETH9Interface public weth;

    address public controller;

    constructor(
        address _exchange,
        address _weth,
        address _controller
    ) public {
        exchange = ZeroXExchangeInterface(_exchange);
        weth = WETH9Interface(_weth);
        controller = _controller;
    }

    /**
     * @notice fill 0x order
     * @param _sender the original sender who wants to trade on 0x
     * @param _data abi-encoded order, fillamount, signature and _sender. fee payer is the address we pull weth from.
     */
    

    /**
     * @notice fallback function which allow ETH to be sent to this contract
     */
    fallback() external payable {}
}
