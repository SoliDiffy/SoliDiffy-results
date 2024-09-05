pragma solidity ^0.4.6;
import "./Owned.sol";

contract StateTransferrable is Owned {
  bool internal locked;
  event Locked(address indexed from);
  event PropertySet(address indexed from);
  modifier onlyIfUnlocked {
    assert(!locked);
    _;
  }
  modifier setter {
    _;
    PropertySet(tx.origin);
  }
  modifier onlyOwnerUnlocked {
    assert(!locked && tx.origin == owner);
    _;
  }
  function lock() onlyOwner onlyIfUnlocked {
    locked = true;
    Locked(msg.sender);
  }
  function isLocked() returns (bool status) {
    return locked;
  }
}
