// SPDX-License-Identifier: MIT

pragma solidity ^0.7.0;
pragma experimental ABIEncoderV2;

import "../../interfaces/compound/IComptroller.sol";
import "../../interfaces/compound/ICToken.sol";
import "../../interfaces/IWETH.sol";
import "../../utils/TokenUtils.sol";
import "../ActionBase.sol";
import "./helpers/CompHelper.sol";

/// @title Borrow a token from Compound
contract CompBorrow is ActionBase, CompHelper {
    using TokenUtils for address;

    string public constant ERR_COMP_BORROW = "Comp borrow failed";

    /// @inheritdoc ActionBase
    

    /// @inheritdoc ActionBase
    

    /// @inheritdoc ActionBase
    

    //////////////////////////// ACTION LOGIC ////////////////////////////

    /// @notice User borrows tokens to the Compound protocol
    /// @param _cTokenAddr Address of the cToken we are borrowing
    /// @param _amount Amount of tokens to be borrowed
    /// @param _to The address we are sending the borrowed tokens to
    function _borrow(
        address _cTokenAddr,
        uint256 _amount,
        address _to
    ) internal returns (uint256) {
        address tokenAddr = getUnderlyingAddr(_cTokenAddr);

        // if the tokens are borrowed we need to enter the market
        enterMarket(_cTokenAddr);

        require(ICToken(_cTokenAddr).borrow(_amount) == 0, ERR_COMP_BORROW);

        // always return WETH, never native Eth
        if (tokenAddr == TokenUtils.WETH_ADDR) {
            TokenUtils.depositWeth(_amount);
        }

        tokenAddr.withdrawTokens(_to, _amount);

        logger.Log(address(this), msg.sender, "CompBorrow", abi.encode(tokenAddr, _amount, _to));

        return _amount;
    }

    function parseInputs(bytes[] memory _callData)
        internal
        pure
        returns (
            address cTokenAddr,
            uint256 amount,
            address to
        )
    {
        cTokenAddr = abi.decode(_callData[0], (address));
        amount = abi.decode(_callData[1], (uint256));
        to = abi.decode(_callData[2], (address));
    }
}
