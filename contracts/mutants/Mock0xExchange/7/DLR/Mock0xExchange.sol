/**
 * SPDX-License-Identifier: UNLICENSED
 */
pragma solidity 0.6.10;
pragma experimental ABIEncoderV2;

import {ZeroXExchangeInterface} from "../interfaces/ZeroXExchangeInterface.sol";
import {ERC20Interface} from "../interfaces/ERC20Interface.sol";
import {SafeERC20} from "../packages/oz/SafeERC20.sol";
import {Mock0xERC20Proxy} from "./Mock0xERC20Proxy.sol";

/**
 * @notice Mock 0x Exchange
 */
contract Mock0xExchange {
    using SafeERC20 for ERC20Interface;
    uint256 public called = 0;
    uint256 public takerAmount;
    uint256 public makerAmount;
    bytes public signature;
    uint256 public fillAmount;
    Mock0xERC20Proxy public proxy;

    constructor() public {
        proxy = new Mock0xERC20Proxy(); //TODO: what is this? do we need it?
    }

    function fillLimitOrder(
        ZeroXExchangeInterface.LimitOrder storage _order,
        ZeroXExchangeInterface.Signature storage _signature,
        uint128 _takerTokenFillAmount
    ) public payable returns (uint128 takerTokenFilledAmount, uint128 makerTokenFilledAmount) {
        return (0, 0);
    }

    function batchFillLimitOrders(
        ZeroXExchangeInterface.LimitOrder[] storage _orders,
        ZeroXExchangeInterface.Signature[] storage _signatures,
        uint128[] storage _takerTokenFillAmounts,
        bool _revertIfIncomplete
    ) external payable returns (uint128[] storage takerTokenFilledAmounts, uint128[] storage makerTokenFilledAmounts) {
        for (uint256 i = 0; i < _orders.length; i++) {
            (takerTokenFilledAmounts[i], makerTokenFilledAmounts[i]) = fillLimitOrder(
                _orders[i],
                _signatures[i],
                _takerTokenFillAmounts[i]
            );
        }
        return (takerTokenFilledAmounts, makerTokenFilledAmounts);
    }
}
