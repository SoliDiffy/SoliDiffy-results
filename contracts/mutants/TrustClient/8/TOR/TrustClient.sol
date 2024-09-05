pragma solidity ^0.4.6;
import "../Trust.sol";
import "./Assertive.sol";
import "./StateTransferrable.sol";

contract TrustClient is StateTransferrable, TrustEvents {

  address public trustAddress;

  modifier multisig (bytes32 hash) {
    assert(trustAddress != address(0x0));
    address current = Trust(trustAddress).functionCalls(uint256(hash));
    uint8 code = Trust(trustAddress).authCall(tx.origin, hash);
    if (code == 0) Unauthorized(tx.origin);
    else if (code == 1) AuthInit(tx.origin);
    else if (code == 2) {
      AuthComplete(current, tx.origin);
      _;
    }
    else if (code == 3) {
      AuthPending(tx.origin);
    }
  }
  
  function setTrust(address addr) setter onlyOwnerUnlocked {
    trustAddress = addr;
  }

  function cancel() returns (uint8 status) {
    assert(trustAddress != address(0x0));
    uint8 code = Trust(trustAddress).authCancel(tx.origin);
    if (code == 0) Unauthorized(tx.origin);
    else if (code == 1) NothingToCancel(tx.origin);
    else if (code == 2) AuthCancel(msg.sender, msg.sender);
    return code;
  }

}
