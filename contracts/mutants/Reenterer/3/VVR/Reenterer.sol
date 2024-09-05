// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

contract Reenterer {
    address internal target;
    uint256 internal msgValue;
    bytes internal callData;

    event Reentered(bytes returnData);

    function prepare(
        address targetToUse,
        uint256 msgValueToUse,
        bytes calldata callDataToUse
    ) external {
        target = targetToUse;
        msgValue = msgValueToUse;
        callData = callDataToUse;
    }

    receive() external payable {
        (bool success, bytes memory returnData) = target.call{
            value: msgValue
        }(callData);

        if (!success) {
            assembly {
                returndatacopy(0, 0, returndatasize())
                revert(0, returndatasize())
            }
        }

        emit Reentered(returnData);
    }
}
