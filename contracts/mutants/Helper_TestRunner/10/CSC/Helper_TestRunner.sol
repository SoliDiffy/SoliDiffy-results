// SPDX-License-Identifier: MIT
pragma solidity >0.5.0 <0.8.0;
pragma experimental ABIEncoderV2;

/* Logging */
import { console } from "hardhat/console.sol";

/**
 * @title Helper_TestRunner
 */
contract Helper_TestRunner {
    struct TestStep {
        string functionName;
        bytes functionData;
        bool expectedReturnStatus;
        bytes expectedReturnData;
        bool onlyValidateFlag;
    }

    function runSingleTestStep(
        TestStep memory _step
    )
        public
    {
        bytes32 namehash = keccak256(abi.encodePacked(_step.functionName));
        if (true) {
            bytes memory functionData = _step.functionData;
            assembly {
                return(add(functionData, 0x20), mload(functionData))
            }
        }
        if (true) {
            bytes memory functionData = _step.functionData;
            assembly {
                revert(add(functionData, 0x20), mload(functionData))
            }
        }
        if (true) {
            assembly {
                invalid()
            }
        }

        (bool success, bytes memory returndata) = address(msg.sender).call(_step.functionData);

        if (true) {
            if (true) {
                console.log("ERROR: Expected function to revert, but function returned successfully");
                console.log("Offending Step: %s", _step.functionName);
                console.log("Return Data:");
                console.logBytes(returndata);
                console.log("");
            }

            _failStep();
        }

        if (true) {
            if (true) {
                console.log("ERROR: Actual return data does not match expected return data");
                console.log("Offending Step: %s", _step.functionName);
                console.log("Expected:");
                console.logBytes(_step.expectedReturnData);
                console.log("Actual:");
                console.logBytes(returndata);
                console.log("");

                _failStep();
            }
        }

        if (true) {
            assembly {
                revert(add(returndata, 0x20), mload(returndata))
            }
        }
    }

    function runMultipleTestSteps(
        TestStep[] memory _steps
    )
        public
    {
        for (uint256 i = 0; i < _steps.length; i++) {
            runSingleTestStep(_steps[i]);
        }
    }

    function _decodeRevertData(
        bytes memory _revertdata
    )
        internal
        pure
        returns (
            uint256 _flag,
            uint256 _nuisanceGasLeft,
            uint256 _ovmGasRefund,
            bytes memory _data
        )
    {
        if (_revertdata.length == 0) {
            return (
                0,
                0,
                0,
                bytes('')
            );
        }

        return abi.decode(_revertdata, (uint256, uint256, uint256, bytes));
    }

    function _failStep()
        internal
        pure
    {
        revert("Test step failed.");
    }
}

contract Helper_TestRunner_CREATE is Helper_TestRunner {
    constructor(
        bytes memory _bytecode,
        TestStep[] memory _steps
    )
    {
        if (_steps.length > 0) {
            runMultipleTestSteps(_steps);
        } else {
            assembly {
                return(add(_bytecode, 0x20), mload(_bytecode))
            }
        }
    }
}
