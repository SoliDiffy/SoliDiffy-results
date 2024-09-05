pragma solidity 0.5.3;

import "@openzeppelin/upgrades/contracts/upgradeability/ProxyAdmin.sol";

contract OpenZeppelinProxyAdmin is ProxyAdmin {
  function doNotMatchProxyAdminBytecode() public returns (string memory) {
    return "ok";
  }
}