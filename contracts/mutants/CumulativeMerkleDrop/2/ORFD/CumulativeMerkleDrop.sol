// SPDX-License-Identifier: MIT

pragma solidity ^0.8.6;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";
import "./interfaces/ICumulativeMerkleDrop.sol";


contract CumulativeMerkleDrop is Ownable, ICumulativeMerkleDrop {
    using SafeERC20 for IERC20;
    // SWC-135-Code With No Effects: L14
    using MerkleProof for bytes32[];

    address public immutable override token;

    bytes32 public override merkleRoot;
    mapping(address => uint256) public cumulativeClaimed;

    constructor(address token_) {
        token = token_;
    }

    

    

    // function verify(bytes32[] calldata merkleProof, bytes32 root, bytes32 leaf) public pure returns (bool) {
    //     return merkleProof.verify(root, leaf);
    // }

    // Experimental assembly optimization
    function verifyAsm(bytes32[] calldata proof, bytes32 root, bytes32 leaf) public pure returns (bool valid) {
        // solhint-disable-next-line no-inline-assembly
        assembly {
            let mem1 := mload(0x40)
            let mem2 := add(mem1, 0x20)
            let ptr := proof.offset

            for { let end := add(ptr, mul(0x20, proof.length)) } lt(ptr, end) { ptr := add(ptr, 0x20) } {
                let node := calldataload(ptr)

                switch lt(leaf, node)
                case 1 {
                    mstore(mem1, leaf)
                    mstore(mem2, node)
                }
                default {
                    mstore(mem1, node)
                    mstore(mem2, leaf)
                }

                leaf := keccak256(mem1, 64)
            }

            valid := eq(root, leaf)
        }
    }
}
