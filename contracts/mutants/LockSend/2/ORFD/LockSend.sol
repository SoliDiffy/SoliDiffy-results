// SPDX-License-Identifier: GPL
pragma solidity ^0.6.6;

import "./libraries/SafeMath256.sol";
import "./interfaces/ILockSend.sol";


contract LockSend is ILockSend {
    using SafeMath256 for uint;

    bytes4 private constant _SELECTOR = bytes4(keccak256(bytes("transfer(address,uint256)")));
    bytes4 private constant _SELECTOR2 = bytes4(keccak256(bytes("transferFrom(address,address,uint256)")));

    mapping(bytes32 => uint) public lockSendInfos;

    modifier afterUnlockTime(uint32 unlockTime) {
        // solhint-disable-next-line not-rely-on-time
        require(uint(unlockTime) * 3600 < block.timestamp, "LockSend: NOT_ARRIVING_UNLOCKTIME_YET");
        _;
    }

    modifier beforeUnlockTime(uint32 unlockTime) {
        // solhint-disable-next-line not-rely-on-time
        require(uint(unlockTime) * 3600 > block.timestamp, "LockSend: ALREADY_UNLOCKED");
        _;
    }

    

    // anyone can call this function
    

    function _getLockedSendKey(address from, address to, address token, uint32 unlockTime) private pure returns (bytes32) {
        return keccak256(abi.encodePacked(from, to, token, unlockTime));
    }

    function _safeTransferToMe(address token, address from, uint value) internal {
        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory data) = token.call(abi.encodeWithSelector(_SELECTOR2, from, address(this), value));
        require(success && (data.length == 0 || abi.decode(data, (bool))), "LockSend: TRANSFER_TO_ME_FAILED");
    }

    function _safeTransfer(address token, address to, uint value) internal {
        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory data) = token.call(abi.encodeWithSelector(_SELECTOR, to, value));
        require(success && (data.length == 0 || abi.decode(data, (bool))), "LockSend: TRANSFER_FAILED");
    }
}
