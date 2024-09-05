// SPDX-License-Identifier: MIT

pragma solidity =0.6.12;

import "@openzeppelin/contracts/math/SafeMath.sol";


library Random {
    using SafeMath for uint256;
    //SWC-120-Weak Sources of Randomness from Chain Attributes: L11-L35
    function computerSeed() internal view returns (uint256) {
        uint256 seed =
        uint256(
            keccak256(
                abi.encodePacked(
                    (block.number)
                    .add(block.number)
                    .add(
                        (
                        uint256(
                            keccak256(abi.encodePacked(tx.origin))
                        )
                        ) / (block.number)
                    )
                    .add(block.gaslimit)
                    .add(
                        (uint256(keccak256(abi.encodePacked(msg.sender)))) /
                        (block.number)
                    )
                    .add(block.number)
                )
            )
        );
        return seed;
    }
}