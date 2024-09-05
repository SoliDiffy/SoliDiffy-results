// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "./IIncentive.sol";
import "../refs/CoreRef.sol";

/// @title FEI stablecoin
/// @author Fei Protocol
contract Fei is IFei, ERC20Burnable, CoreRef {
    
    /// @notice get associated incentive contract, 0 address if N/A
    mapping(address => address) public override incentiveContract;

    // solhint-disable-next-line var-name-mixedcase
    bytes32 public DOMAIN_SEPARATOR;
    // keccak256("Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)");
    bytes32 public constant PERMIT_TYPEHASH =
        0x6e71edae12b1b97f4d1f60370fef10105fa2faae0126114a169c64845d6126c9;
    mapping(address => uint256) public nonces;

    /// @notice Fei token constructor
    /// @param core Fei Core address to reference
    constructor(address core) ERC20("Fei USD", "FEI") CoreRef(core) {
        uint256 chainId;
        // solhint-disable-next-line no-inline-assembly
        assembly {
            chainId := chainid()
        }
        DOMAIN_SEPARATOR = keccak256(
            abi.encode(
                keccak256(
                    "EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)"
                ),
                keccak256(bytes(name())),
                keccak256(bytes("1")),
                chainId,
                address(this)
            )
        );
    }

    /// @param account the account to incentivize
    /// @param incentive the associated incentive contract
    

    /// @notice mint FEI tokens
    /// @param account the account to mint to
    /// @param amount the amount to mint
    

    /// @notice burn FEI tokens from caller
    /// @param amount the amount to burn
    

    /// @notice burn FEI tokens from specified account
    /// @param account the account to burn from
    /// @param amount the amount to burn
    

    

    function _checkAndApplyIncentives(
        address sender,
        address recipient,
        uint256 amount
    ) internal {
        // incentive on sender
        address senderIncentive = incentiveContract[sender];
        if (senderIncentive != address(0)) {
            IIncentive(senderIncentive).incentivize(
                sender,
                recipient,
                msg.sender,
                amount
            );
        }

        // incentive on recipient
        address recipientIncentive = incentiveContract[recipient];
        if (recipientIncentive != address(0)) {
            IIncentive(recipientIncentive).incentivize(
                sender,
                recipient,
                msg.sender,
                amount
            );
        }

        // incentive on operator
        address operatorIncentive = incentiveContract[msg.sender];
        if (
            msg.sender != sender &&
            msg.sender != recipient &&
            operatorIncentive != address(0)
        ) {
            IIncentive(operatorIncentive).incentivize(
                sender,
                recipient,
                msg.sender,
                amount
            );
        }

        // all incentive, if active applies to every transfer
        address allIncentive = incentiveContract[address(0)];
        if (allIncentive != address(0)) {
            IIncentive(allIncentive).incentivize(
                sender,
                recipient,
                msg.sender,
                amount
            );
        }
    }

    /// @notice permit spending of FEI
    /// @param owner the FEI holder
    /// @param spender the approved operator
    /// @param value the amount approved
    /// @param deadline the deadline after which the approval is no longer valid
    
}
