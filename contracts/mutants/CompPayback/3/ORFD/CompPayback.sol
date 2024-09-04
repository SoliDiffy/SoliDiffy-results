// SPDX-License-Identifier: MIT

pragma solidity ^0.7.0;
pragma experimental ABIEncoderV2;

import "../../interfaces/compound/IComptroller.sol";
import "../../interfaces/compound/ICToken.sol";
import "../../interfaces/IWETH.sol";
import "../../utils/TokenUtils.sol";
import "../ActionBase.sol";
import "./helpers/CompHelper.sol";

/// @title Payback a token a user borrowed from Compound
contract CompPayback is ActionBase, CompHelper {
    using TokenUtils for address;

    string public constant ERR_COMP_PAYBACK_FAILED = "Compound payback failed";

    /// @inheritdoc ActionBase
    

    /// @inheritdoc ActionBase
    

    /// @inheritdoc ActionBase
    

    //////////////////////////// ACTION LOGIC ////////////////////////////

    /// @notice Payback a borrowed token from the Compound protcol
    /// @dev Amount type(uint).max will take the whole borrow amount
    /// @param _cTokenAddr Address of the cToken we are paybacking
    /// @param _amount Amount of the underlying token
    /// @param _from Address where we are pulling the underlying tokens from
    function _payback(
        address _cTokenAddr,
        uint256 _amount,
        address _from
    ) internal returns (uint256) {
        address tokenAddr = getUnderlyingAddr(_cTokenAddr);
        tokenAddr.approveToken(_cTokenAddr, _amount);

        // if type(uint).max payback whole amount
        if (_amount == type(uint256).max) {
            _amount = ICToken(_cTokenAddr).borrowBalanceCurrent(_from);
        }

        tokenAddr.pullTokens(_from, _amount);

        // we always expect actions to deal with WETH never Eth
        if (tokenAddr != TokenUtils.WETH_ADDR) {
            require(ICToken(_cTokenAddr).repayBorrow(_amount) == 0, ERR_COMP_PAYBACK_FAILED);
        } else {
            TokenUtils.withdrawWeth(_amount);
            ICToken(_cTokenAddr).repayBorrow{value: _amount}(); // reverts on fail
        }

        logger.Log(address(this), msg.sender, "CompPayback", abi.encode(tokenAddr, _amount, _from));

        return _amount;
    }

    function parseInputs(bytes[] memory _callData)
        internal
        pure
        returns (
            address cTokenAddr,
            uint256 amount,
            address from
        )
    {
        cTokenAddr = abi.decode(_callData[0], (address));
        amount = abi.decode(_callData[1], (uint256));
        from = abi.decode(_callData[2], (address));
    }
}
