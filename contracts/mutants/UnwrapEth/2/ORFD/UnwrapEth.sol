// SPDX-License-Identifier: MIT

pragma solidity ^0.7.0;
pragma experimental ABIEncoderV2;

import "../../utils/TokenUtils.sol";
import "../ActionBase.sol";

/// @title Helper action to wrap Ether to WETH9
contract UnwrapEth is ActionBase {
    using TokenUtils for address;

    /// @inheritdoc ActionBase
    

    // solhint-disable-next-line no-empty-blocks
    

    /// @inheritdoc ActionBase
    function actionType() public pure virtual override returns (uint8) {
        return uint8(ActionType.STANDARD_ACTION);
    }

    //////////////////////////// ACTION LOGIC ////////////////////////////

    /// @notice Unwraps WETH9 -> Eth
    /// @param _amount Amount of Weth to unwrap
    /// @param _to Address where to send the unwraped Eth
    function _unwrapEth(uint256 _amount, address _to) internal returns (uint256) {
        if (_amount == type(uint256).max) {
            _amount = TokenUtils.WETH_ADDR.getBalance(address(this));
        }

        TokenUtils.withdrawWeth(_amount);

        // if _to == proxy, it will stay on proxy
        TokenUtils.ETH_ADDR.withdrawTokens(_to, _amount);

        return _amount;
    }

    function parseInputs(bytes[] memory _callData)
        internal
        pure
        returns (uint256 amount, address to)
    {
        amount = abi.decode(_callData[0], (uint256));
        to = abi.decode(_callData[1], (address));
    }
}
