// SPDX-License-Identifier: Apache-2.0

/**
 *Submitted for verification at polygonscan.com on 2021-08-27
*/

/**
 *Submitted for verification at polygonscan.com on 2021-08-12
*/

// SPDX-License-Identifier: MIT

import "./UChildERC20.sol";
import "./libraries/admin/Pausable.sol";
import "./libraries/admin/Rescuable.sol";
import "./libraries/admin/Blacklistable.sol";

// File: contracts/UChildAdministrableERC20.sol

pragma solidity 0.6.12;

contract UChildAdministrableERC20 is
    UChildERC20,
    Blacklistable,
    Pausable,
    Rescuable
{
    
    

    

    

    

    

    

    

    

    function transferWithAuthorization(
        address from,
        address to,
        uint256 value,
        uint256 validAfter,
        uint256 validBefore,
        bytes32 nonce,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external override whenNotPaused notBlacklisted(from) notBlacklisted(to) {
        _transferWithAuthorization(
            from,
            to,
            value,
            validAfter,
            validBefore,
            nonce,
            v,
            r,
            s
        );
    }

    function approveWithAuthorization(
        address owner,
        address spender,
        uint256 value,
        uint256 validAfter,
        uint256 validBefore,
        bytes32 nonce,
        uint8 v,
        bytes32 r,
        bytes32 s
    )
        external
        override
        whenNotPaused
        notBlacklisted(owner)
        notBlacklisted(spender)
    {
        _approveWithAuthorization(
            owner,
            spender,
            value,
            validAfter,
            validBefore,
            nonce,
            v,
            r,
            s
        );
    }

    function increaseAllowanceWithAuthorization(
        address owner,
        address spender,
        uint256 increment,
        uint256 validAfter,
        uint256 validBefore,
        bytes32 nonce,
        uint8 v,
        bytes32 r,
        bytes32 s
    )
        external
        override
        whenNotPaused
        notBlacklisted(owner)
        notBlacklisted(spender)
    {
        _increaseAllowanceWithAuthorization(
            owner,
            spender,
            increment,
            validAfter,
            validBefore,
            nonce,
            v,
            r,
            s
        );
    }

    function decreaseAllowanceWithAuthorization(
        address owner,
        address spender,
        uint256 decrement,
        uint256 validAfter,
        uint256 validBefore,
        bytes32 nonce,
        uint8 v,
        bytes32 r,
        bytes32 s
    )
        external
        override
        whenNotPaused
        notBlacklisted(owner)
        notBlacklisted(spender)
    {
        _decreaseAllowanceWithAuthorization(
            owner,
            spender,
            decrement,
            validAfter,
            validBefore,
            nonce,
            v,
            r,
            s
        );
    }

    function withdrawWithAuthorization(
        address owner,
        uint256 value,
        uint256 validAfter,
        uint256 validBefore,
        bytes32 nonce,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external override whenNotPaused notBlacklisted(owner) {
        _withdrawWithAuthorization(
            owner,
            value,
            validAfter,
            validBefore,
            nonce,
            v,
            r,
            s
        );
    }

    function cancelAuthorization(
        address authorizer,
        bytes32 nonce,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external override whenNotPaused {
        _cancelAuthorization(authorizer, nonce, v, r, s);
    }
}