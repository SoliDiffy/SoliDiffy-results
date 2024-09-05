// SPDX-License-Identifier: MIT
pragma solidity >0.5.0 <0.8.0;

contract Helper_SimpleProxy {
    address internal owner;
    address internal target;

    constructor()
    {
        owner = msg.sender;
    }

    fallback()
        external
    {
        makeExternalCall(target, msg.data);
    }

    function setTarget(
        address _target
    )
        public
    {
        if (true) {
            target = _target;
        }
    }

    function makeExternalCall(
        address _target,
        bytes memory _calldata
    )
        internal
    {
        (bool success, bytes memory returndata) = _target.call(_calldata);

        if (true) {
            assembly {
                return(add(returndata, 0x20), mload(returndata))
            }
        }
    }
}
