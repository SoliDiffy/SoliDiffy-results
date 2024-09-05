// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.8.0;

interface IPermitAllowed {
    function nonces(address owner) external view returns (uint256);

    // DAI
    

    // Uniswap & USDC
    

    // COMP
    function delegateBySig(
        address delegatee,
        uint256 nonce,
        uint256 expiry,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external;
}
