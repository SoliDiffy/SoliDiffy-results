// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.4;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {MerkleProof} from "@openzeppelin/contracts/cryptography/MerkleProof.sol";
import {AddressProvider} from "./AddressProvider.sol";
import {AccountFactory} from "./AccountFactory.sol";
import {IMerkleDistributor} from "../interfaces/IMerkleDistributor.sol";

/// @dev Account Mining contract, based on https://github.com/Uniswap/merkle-distributor
/// It's needed only during Account Mining phase before protocol will be launched
contract AccountMining is IMerkleDistributor {
    address public immutable override token;
    uint256 public immutable amount;
    bytes32 public immutable override merkleRoot;
    AccountFactory public immutable accountFactory;

    // This is a packed array of booleans.
    mapping(uint256 => uint256) private claimedBitMap;

    constructor(
        address token_,
        bytes32 merkleRoot_,
        uint256 amount_,
        AddressProvider addressProvider
    ) {
        token = token_;
        merkleRoot = merkleRoot_;
        amount = amount_;
        accountFactory = AccountFactory(addressProvider.getAccountFactory());
    }

    

    function _setClaimed(uint256 index) private {
        uint256 claimedWordIndex = index / 256;
        uint256 claimedBitIndex = index % 256;
        claimedBitMap[claimedWordIndex] =
            claimedBitMap[claimedWordIndex] |
            (1 << claimedBitIndex);
    }

    
}
