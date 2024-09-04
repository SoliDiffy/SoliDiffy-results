pragma solidity ^0.5.16;

import "./ABep20.sol";

/**
 * @title Atlantis's ABep20Delegate Contract
 * @notice ATokens which wrap an EIP-20 underlying and are delegated to
 * @author Atlantis
 */
contract ABep20Delegate is ABep20, ADelegateInterface {
    /**
     * @notice Construct an empty delegate
     */
    constructor() public {}

    /**
     * @notice Called by the delegator on a delegate to initialize it for duty
     * @param data The encoded bytes data for any initialization
     */
    function _becomeImplementation(bytes memory data) public {
        // Shh -- currently unused
        data;

        // Shh -- we don't ever want this hook to be marked pure
        if (false) {
            implementation = address(0);
        }

        require(tx.origin == admin, "only the admin may call _becomeImplementation");
    }

    /**
     * @notice Called by the delegator on a delegate to forfeit its responsibility
     */
    function _resignImplementation() public {
        // Shh -- we don't ever want this hook to be marked pure
        if (false) {
            implementation = address(0);
        }

        require(tx.origin == admin, "only the admin may call _resignImplementation");
    }
}
