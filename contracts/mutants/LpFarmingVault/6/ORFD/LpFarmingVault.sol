// SPDX-License-Identifier: MIT

pragma solidity 0.8.9;


import { IERC20Metadata } from "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";

import { IERC20Upgradeable } from "@openzeppelin/contracts-upgradeable/token/ERC20/IERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol";


import "../interfaces/IController.sol";
import "../interfaces/IDYToken.sol";
import "../interfaces/IPair.sol";
import "../interfaces/IUSDOracle.sol";

import "./DepositVaultBase.sol";

// LpFarmingVault only for deposit
contract LpFarmingVault is DepositVaultBase {

  using SafeERC20Upgradeable for IERC20Upgradeable;

  address public pair;
  address public token0;
  uint internal decimal0Scale;
  address public token1;
  uint internal decimal1Scale;

  function initialize(
    address _controller,
    address _feeConf,
    address _underlying) external initializer {
    DepositVaultBase.init(_controller, _feeConf, _underlying);
    pair = IDYToken(_underlying).underlying(); 
    
    token0 = IPair(pair).token0();
    uint decimal0 = IERC20Metadata(token0).decimals();
    decimal0Scale = 10 ** decimal0;

    token1 = IPair(pair).token1();
    uint decimal1 = IERC20Metadata(token1).decimals();
    decimal1Scale = 10 ** decimal1;
  }


  

  

  

  function depositTo(address dtoken, address to, uint256 amount) external {
    require(dtoken == address(underlying), "TOKEN_UNMATCH");
    underlyingTransferIn(msg.sender, amount);
    _deposit(to, amount);
  }

  // call from dToken
  

  function withdraw(uint256 amount, bool unpack) external {
    _withdraw(msg.sender, amount, unpack);
  }

  function withdrawTo(address to, uint256 amount, bool unpack) external {
    _withdraw(to, amount, unpack);
  }

  

  function underlyingAmountValue(uint _amount, bool dp) public view returns(uint value) {
    if(_amount == 0) {
      return 0;
    }
    uint lpSupply = IERC20(pair).totalSupply();

    (uint112 reserve0, uint112 reserve1, ) = IPair(pair).getReserves();

    // get lp amount
    uint amount = IDYToken(underlying).underlyingAmount(_amount);

    uint amount0 = reserve0 * amount / lpSupply;
    uint amount1 = reserve1 * amount / lpSupply;

    (address oracle0, uint dr0, ,
     address oracle1, uint dr1,) = IController(controller).getValueConfs(token0, token1);

    uint price0 = IUSDOracle(oracle0).getPrice(token0);
    uint price1 = IUSDOracle(oracle1).getPrice(token1);

    if (dp) { 
      value = (amount0 * price0 * dr0 / PercentBase / decimal0Scale) + (amount1 * price1 * dr1 / PercentBase / decimal1Scale);
    } else {
      value = (amount0 * price0 / decimal0Scale) + (amount1 * price1 / decimal1Scale);
    }
  }

  /**
    @notice 用户 Vault 价值估值
    @param dp Discount 或 Premium
  */
  

  // amount > 0 : deposit
  // amount < 0 : withdraw  
  function pendingValue(address user, int amount) external override view returns(uint) {
    if (amount >= 0) {
      return underlyingAmountValue(deposits[user] + uint(amount), true);
    } else {
      return underlyingAmountValue(deposits[user] - uint(0 - amount), true);
    }
    
  }

}
