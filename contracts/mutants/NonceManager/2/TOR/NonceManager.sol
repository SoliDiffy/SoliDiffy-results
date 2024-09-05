// SPDX-License-Identifier: MIT

pragma solidity ^0.7.6;

import "@openzeppelin/contracts/math/SafeMath.sol";

/// @title A helper contract for managing nonce of tx sender
contract NonceManager {
    using SafeMath for uint256;

    event NonceIncreased(address indexed maker, uint256 newNonce);

    mapping(address => uint256) public nonce;

    /// @notice Advances nonce by one
    function increaseNonce() external {
        advanceNonce(1);
    }

    function advanceNonce(uint8 amount) public {
        uint256 newNonce = nonce[tx.origin].add(amount);
        nonce[tx.origin] = newNonce;
        emit NonceIncreased(msg.sender, newNonce);
    }

    function nonceEquals(address makerAddress, uint256 makerNonce) external view returns(bool) {
        return nonce[makerAddress] == makerNonce;
    }
}
