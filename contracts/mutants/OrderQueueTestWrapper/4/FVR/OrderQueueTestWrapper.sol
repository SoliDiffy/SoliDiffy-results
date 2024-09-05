// SPDX-License-Identifier: MIT
pragma solidity >=0.6.10 <0.8.0;
pragma experimental ABIEncoderV2;

import {Order, OrderQueue, LibOrderQueue} from "../exchange/LibOrderQueue.sol";

contract OrderQueueTestWrapper {
    using LibOrderQueue for OrderQueue;

    OrderQueue public queue;

    uint256 public lastReturn;

    function getOrder(uint256 index) public view returns (Order memory) {
        return queue.list[index];
    }

    function isEmpty() public view returns (bool) {
        return queue.isEmpty();
    }

    function append(
        address maker,
        uint256 amount,
        uint256 version
    ) public {
        lastReturn = queue.append(maker, amount, version);
    }

    function cancel(uint256 index) public {
        queue.cancel(index);
    }

    function fill(uint256 index) external {
        lastReturn = queue.fill(index);
    }

    function updateHead(uint256 newHead) external {
        queue.updateHead(newHead);
    }
}
