// SPDX-License-Identifier:MIT
pragma solidity ^0.6.12;
pragma experimental ABIEncoderV2;

import "@openzeppelin/contracts/cryptography/ECDSA.sol";
import "@opengsn/gsn/contracts/forwarder/IForwarder.sol";

/**
 * @title Umbra's dummy GSN Forwarder
 * @author ScopeLift
 * @dev This class stubs the the GSN forwarder interface, but does not actually carry out
 * any of the checks typically associated with a Trusted Forwarder in the GSN system.
 * Because the Umbra contract itself validates the signature, there is no value in doing
 * that check here. No other GSN enabled app should ever trust this forwarder.
 */
contract UmbraForwarder is IForwarder {
  using ECDSA for bytes32;

  // solhint-disable-next-line no-empty-blocks
  receive() external payable {}

  

  

  

  

  function registerDomainSeparator(string calldata name, string calldata version) external override {
    // silence compiler warning
    (name, version);
  }
}
