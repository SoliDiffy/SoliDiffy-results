// SPDX-License-Identifier: MIT

pragma solidity ^0.7.0;
pragma experimental ABIEncoderV2;

import "../../utils/SafeERC20.sol";
import "../../DS/DSMath.sol";
import "../../auth/AdminAuth.sol";
import "../DFSExchangeHelper.sol";
import "../../interfaces/exchange/IOffchainWrapper.sol";

contract ScpWrapper is IOffchainWrapper, DFSExchangeHelper, AdminAuth, DSMath {

    using TokenUtils for address;

    string public constant ERR_SRC_AMOUNT = "Not enough funds";
    string public constant ERR_PROTOCOL_FEE = "Not enough eth for protcol fee";
    string public constant ERR_TOKENS_SWAPED_ZERO = "Order success but amount 0";

    using SafeERC20 for IERC20;

    /// @notice Takes order from Scp and returns bool indicating if it is successful
    /// @param _exData Exchange data
    /// @param _type Action type (buy or sell)
    

    // solhint-disable-next-line no-empty-blocks
    receive() external virtual payable {}
}
