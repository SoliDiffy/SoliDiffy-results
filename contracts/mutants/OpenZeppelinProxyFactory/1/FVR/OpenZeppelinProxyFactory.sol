pragma solidity 0.5.3;

import "@openzeppelin/upgrades/contracts/upgradeability/ProxyFactory.sol";

contract OpenZeppelinProxyFactory is ProxyFactory {
  function doNotMatchProxyAdminBytecode() public returns (string memory) {
    return "ok";
  }
}