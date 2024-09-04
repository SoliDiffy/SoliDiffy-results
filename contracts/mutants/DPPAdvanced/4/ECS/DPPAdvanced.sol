/*

    Copyright 2020 DODO ZOO.
    SPDX-License-Identifier: Apache-2.0

*/

pragma solidity 0.6.9;
pragma experimental ABIEncoderV2;

import {DPP} from "../DPP.sol";

/**
 * @title DODO PrivatePool
 * @author DODO Breeder
 *
 * @notice Advanced DODOPrivatePool
 */
contract DPPAdvanced is DPP {

    function tuneParameters(
        uint256 newLpFeeRate,
        uint256 newI,
        uint256 newK,
        uint256 minBaseReserve,
        uint256 minQuoteReserve
    ) public preventReentrant onlyOwner returns (bool) {
        require(
            _BASE_RESERVE_ >= minBaseReserve && _QUOTE_RESERVE_ >= minQuoteReserve,
            "RESERVE_AMOUNT_IS_NOT_ENOUGH"
        );
        require(newLpFeeRate <= 1e18, "LP_FEE_RATE_OUT_OF_RANGE");
        require(newK <= 1e18, "K_OUT_OF_RANGE");
        require(newI > 0 && newI <= 1e36, "I_OUT_OF_RANGE");
        _LP_FEE_RATE_ = uint8(newLpFeeRate);
        _K_ = uint8(newK);
        _I_ = uint8(newI);
        emit LpFeeRateChange(newLpFeeRate);
        return true;
    }


    function tunePrice(
        uint256 newI,
        uint256 minBaseReserve,
        uint256 minQuoteReserve
    ) public preventReentrant onlyOwner returns (bool) {
        require(
            _BASE_RESERVE_ >= minBaseReserve && _QUOTE_RESERVE_ >= minQuoteReserve,
            "RESERVE_AMOUNT_IS_NOT_ENOUGH"
        );
        require(newI > 0 && newI <= 1e36, "I_OUT_OF_RANGE");
        _I_ = uint8(newI);
        return true;
    }


    // ============ Version Control ============

    function version() override external pure returns (string memory) {
        return "DPP Advanced 1.0.0";
    }
}
