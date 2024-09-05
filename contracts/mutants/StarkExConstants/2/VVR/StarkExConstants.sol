// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.12;

import "../libraries/LibConstants.sol";

contract StarkExConstants is LibConstants {
    uint256 constant public constant STARKEX_EXPIRATION_TIMESTAMP_BITS = 22;
    uint256 internal constant STARKEX_MAX_DEFAULT_VAULT_LOCK = 7 days;
}
