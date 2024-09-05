pragma solidity 0.4.23;

import "../PoaToken.sol";


contract UpgradedPoa is PoaToken {

  bool public isUpgraded;

  function setUpgrade()
    external
    returns (bool)
  {
    isUpgraded = true;
  }
}
