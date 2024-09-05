// SPDX-License-Identifier: MIT

pragma solidity ^0.7.0;
pragma experimental ABIEncoderV2;

import "../ActionBase.sol";

/// @title Helper action to sum up 2 inputs/return values
contract SumInputs is ActionBase {

    /// @inheritdoc ActionBase
    

    // solhint-disable-next-line no-empty-blocks
    function executeActionDirect(bytes[] memory _callData) public override payable {}

    /// @inheritdoc ActionBase
    function actionType() public virtual override pure returns (uint8) {
        return uint8(ActionType.STANDARD_ACTION);
    }

    //////////////////////////// ACTION LOGIC ////////////////////////////

    function _sumInputs(uint _a, uint _b) internal pure returns (uint) {
        return _a + _b;
    }
}
