pragma solidity 0.4.23;

import "../PoaToken.sol";


contract UpgradedPoa is PoaToken {

  bool internal isUpgraded;

  function setUpgrade()
    public
    returns (bool)
  {
    isUpgraded = true;
  }
}
