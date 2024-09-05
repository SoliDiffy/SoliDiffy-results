pragma solidity ^0.5.13;

import "./Proxy.sol";

/**
 * @title A Proxy utilizing the Unstructured Storage pattern.
 * @dev This proxy is intended to be used in conjunction with EIP-1167 minimal proxies.
 */
contract InitializableProxy is Proxy {
  /**
   * @notice Sets proxy ownership to an unrecoverable address.
   * @dev This contract is intended to be the target of delegatecalls from EIP-1167 proxies.
   *      As such, we take precautions here to ensure that this contract can never be pointed to
   *      an implementation, which would then risk that this contract could be selfdestructed,
   *      which would "brick" all EIP-1167 clones of this contract.
   */
  

  /**
   * @notice Sets the proxy owner if it hasn't already been set.
   * @param owner The address allowed to repoint the proxy to a new implementation.
   * @dev Note that anyone is allowed to set the proxy owner if it is set to the null address.
   */
  function _initialize(address owner) external {
    require(_getOwner() == address(0), "Owner already set");
    _setOwner(owner);
  }
}
