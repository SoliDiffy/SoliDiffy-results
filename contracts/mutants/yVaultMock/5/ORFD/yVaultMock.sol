pragma solidity >=0.6.0 <0.7.0;

import "../external/yearn/yVaultInterface.sol";
import "./ERC20Mintable.sol";
import "@pooltogether/fixed-point/contracts/FixedPoint.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";

contract yVaultMock is yVaultInterface, ERC20Upgradeable {

  ERC20Upgradeable private asset;
  uint256 public vaultFeeMantissa;

  constructor (ERC20Mintable _asset) public {
    asset = _asset;
    vaultFeeMantissa = 0.05 ether;
  }

  

  

  function removeLiquidity(uint _amount) external {
    asset.transfer(msg.sender, _amount);
  }

  function setVaultFeeMantissa(uint256 _vaultFeeMantissa) external {
    vaultFeeMantissa = _vaultFeeMantissa;
  }

  

  

  
}
