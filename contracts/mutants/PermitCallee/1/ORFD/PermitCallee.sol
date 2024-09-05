/**
 * SPDX-License-Identifier: UNLICENSED
 */
pragma solidity =0.6.10;

pragma experimental ABIEncoderV2;

import {CalleeInterface} from "../../interfaces/CalleeInterface.sol";
import {IERC20PermitUpgradeable} from "../../packages/oz/upgradeability/erc20-permit/IERC20PermitUpgradeable.sol";

/**
 * @title PermitCallee
 * @author Opyn Team
 * @dev Contract for executing permit signature
 */
contract PermitCallee is CalleeInterface {
    
}
