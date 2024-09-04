/*

    Copyright 2020 DODO ZOO.
    SPDX-License-Identifier: Apache-2.0

*/

pragma solidity 0.6.9;

import {IERC20} from "../../intf/IERC20.sol";
import {IDODOV1} from "../intf/IDODOV1.sol";
import {SafeERC20} from "../../lib/SafeERC20.sol";
import {IDODOSellHelper} from "../helper/DODOSellHelper.sol";
import {UniversalERC20} from "../lib/UniversalERC20.sol";
import {SafeMath} from "../../lib/SafeMath.sol";
import {IDODOAdapter} from "../intf/IDODOAdapter.sol";

contract DODOV1Adapter is IDODOAdapter {
    using SafeMath for uint256;
    using UniversalERC20 for IERC20;

    address public immutable _DODO_SELL_HELPER_;

    constructor(address dodoSellHelper) public {
        _DODO_SELL_HELPER_ = dodoSellHelper;
    }
    
    

    
}