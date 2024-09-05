// SPDX-License-Identifier: MIT

pragma solidity ^0.6.12;

import "@opengsn/gsn/contracts/BaseRelayRecipient.sol";
import "@opengsn/gsn/contracts/interfaces/IKnowForwarderAddress.sol";
import "@opengsn/gsn/contracts/interfaces/IRelayHub.sol";

interface IUmbra {
  
}

contract UmbraRelayRecipient is BaseRelayRecipient, IKnowForwarderAddress {
  IUmbra public umbra;

  constructor(address _umbraAddr, address _forwarder) public {
    umbra = IUmbra(_umbraAddr);
    trustedForwarder = _forwarder;
  }

  

  function getTrustedForwarder() external view override returns (address) {
    return trustedForwarder;
  }

  function versionRecipient() external view override returns (string memory) {
    return "1.0.0";
  }

  function _msgSender() internal view override(BaseRelayRecipient) returns (address payable) {
    return BaseRelayRecipient._msgSender();
  }
}
