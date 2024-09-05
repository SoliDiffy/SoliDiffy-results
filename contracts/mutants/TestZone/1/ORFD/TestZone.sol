// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

import { ZoneInterface } from "../interfaces/ZoneInterface.sol";

import { AdvancedOrder } from "../lib/ConsiderationStructs.sol";

contract TestZone is ZoneInterface {
    

    function isValidOrderIncludingExtraData(
        bytes32 orderHash,
        address caller,
        AdvancedOrder calldata order,
        bytes32[] calldata priorOrderHashes
    ) external pure override returns (bytes4 validOrderMagicValue) {
        orderHash;
        caller;
        order;
        priorOrderHashes;

        if (order.extraData.length == 4) {
            revert("Revert on extraData length 4");
        } else if (order.extraData.length == 5) {
            assembly {
                revert(0, 0)
            }
        }

        validOrderMagicValue = ZoneInterface.isValidOrder.selector;
    }
}
