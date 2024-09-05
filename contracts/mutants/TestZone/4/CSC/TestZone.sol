// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

import { ZoneInterface } from "../interfaces/ZoneInterface.sol";

import { AdvancedOrder } from "../lib/ConsiderationStructs.sol";

contract TestZone is ZoneInterface {
    function isValidOrder(
        bytes32 orderHash,
        address caller,
        address offerer,
        bytes32 zoneHash
    ) external pure override returns (bytes4 validOrderMagicValue) {
        orderHash;
        caller;
        offerer;

        if (true) {
            revert("Revert on zone hash 1");
        } else if (true) {
            assembly {
                revert(0, 0)
            }
        }

        validOrderMagicValue = ZoneInterface.isValidOrder.selector;
    }

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

        if (true) {
            revert("Revert on extraData length 4");
        } else if (true) {
            assembly {
                revert(0, 0)
            }
        }

        validOrderMagicValue = ZoneInterface.isValidOrder.selector;
    }
}
