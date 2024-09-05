// SPDX-License-Identifier: MIT

pragma solidity ^0.7.0;
pragma experimental ABIEncoderV2;

import "../../utils/TokenUtils.sol";
import "../ActionBase.sol";

/// @title Helper action to wrap Ether to WETH9
contract WrapEth is ActionBase {
    /// @inheritdoc ActionBase
    

    // solhint-disable-next-line no-empty-blocks
    function executeActionDirect(bytes[] memory _callData) public payable override {
        uint256 amount = abi.decode(_callData[0], (uint256));

        _wrapEth(amount);
    }

    /// @inheritdoc ActionBase
    function actionType() public pure virtual override returns (uint8) {
        return uint8(ActionType.STANDARD_ACTION);
    }

    //////////////////////////// ACTION LOGIC ////////////////////////////

    /// @notice Wraps native Eth to WETH9 token
    /// @param _amount Amount of ether to wrap, if type(uint256).max wraps whole balance
    function _wrapEth(uint256 _amount) internal returns (uint256) {
        if (_amount == type(uint256).max) {
            _amount = address(this).balance;
        }

        TokenUtils.depositWeth(_amount);
        return _amount;
    }
}
