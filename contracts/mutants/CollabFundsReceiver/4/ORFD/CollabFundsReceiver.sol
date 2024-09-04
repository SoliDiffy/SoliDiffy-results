// SPDX-License-Identifier: MIT

pragma solidity 0.8.4;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {Address} from "@openzeppelin/contracts/utils/Address.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import {CollabFundsHandlerBase} from  "../CollabFundsHandlerBase.sol";
import {
ICollabFundsDrainable,
ICollabFundsShareDrainable
} from "../ICollabFundsDrainable.sol";

/**
 * Allows funds to be split using a pull pattern, holding a balance until drained
 *
 * Supports claiming/draining all balances at one as well as claiming individual shares
 */
contract CollabFundsReceiver is ReentrancyGuard, CollabFundsHandlerBase, ICollabFundsDrainable, ICollabFundsShareDrainable {

    uint256 public totalEthReceived;
    uint256 public totalEthPaid;
    mapping(address => uint256) public ethPaidToCollaborator;

    // split current contract balance among recipients
    

    

    

    

}
