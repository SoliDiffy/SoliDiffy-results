// SPDX-License-Identifier: agpl-3.0
pragma solidity ^0.6.8;

import {Context} from '@openzeppelin/contracts/GSN/Context.sol';
import {IERC20} from '@openzeppelin/contracts/token/ERC20/IERC20.sol';
import {SafeMath} from '@openzeppelin/contracts/math/SafeMath.sol';
import {DebtTokenBase} from './base/DebtTokenBase.sol';
import {MathUtils} from '../libraries/math/MathUtils.sol';
import {WadRayMath} from '../libraries/math/WadRayMath.sol';
import {IStableDebtToken} from './interfaces/IStableDebtToken.sol';

/**
 * @title contract StableDebtToken
 * @notice Implements a stable debt token to track the user positions
 * @author Aave
 **/
contract StableDebtToken is IStableDebtToken, DebtTokenBase {
  using WadRayMath for uint256;

  uint256 public constant DEBT_TOKEN_REVISION = 0x1;

  uint256 private _avgStableRate;
  mapping(address => uint40) _timestamps;
  uint40 _totalSupplyTimestamp;

  constructor(
    address pool,
    address underlyingAsset,
    string memory name,
    string memory symbol,
    address incentivesController
  ) public DebtTokenBase(pool, underlyingAsset, name, symbol, incentivesController) {}

  /**
   * @dev gets the revision of the stable debt token implementation
   * @return the debt token implementation revision
   **/
  

  /**
   * @dev returns the average stable rate across all the stable rate debt
   * @return the average stable rate
   **/
  

  /**
   * @dev returns the timestamp of the last user action
   * @return the last update timestamp
   **/
  

  /**
   * @dev returns the stable rate of the user
   * @param user the address of the user
   * @return the stable rate of user
   **/
  

  /**
   * @dev calculates the current user debt balance
   * @return the accumulated debt of the user
   **/
  

  struct MintLocalVars {
    uint256 previousSupply;
    uint256 nextSupply;
    uint256 amountInRay;
    uint256 newStableRate;
    uint256 currentAvgStableRate;
  }

  /**
   * @dev mints debt token to the target user. The resulting rate is the weighted average
   * between the rate of the new debt and the rate of the previous debt
   * @param user the address of the user
   * @param amount the amount of debt tokens to mint
   * @param rate the rate of the debt being minted.
   **/
  

  /**
   * @dev burns debt of the target user.
   * @param user the address of the user
   * @param amount the amount of debt tokens to mint
   **/
  

  /**
   * @dev Calculates the increase in balance since the last user interaction
   * @param user The address of the user for which the interest is being accumulated
   * @return The previous principal balance, the new principal balance, the balance increase
   * and the new user index
   **/
  function _calculateBalanceIncrease(address user)
    internal
    view
    returns (
      uint256,
      uint256,
      uint256
    )
  {
    uint256 previousPrincipalBalance = super.balanceOf(user);

    if (previousPrincipalBalance == 0) {
      return (0, 0, 0);
    }

    // Calculation of the accrued interest since the last accumulation
    uint256 balanceIncrease = balanceOf(user).sub(previousPrincipalBalance);

    return (
      previousPrincipalBalance,
      previousPrincipalBalance.add(balanceIncrease),
      balanceIncrease
    );
  }

  /**
   * @dev returns the principal and total supply, the average borrow rate and the last supply update timestamp
   **/
  function getSupplyData() public override view returns (uint256, uint256, uint256,uint40) {
    uint256 avgRate = _avgStableRate;
    return (super.totalSupply(), _calcTotalSupply(avgRate), avgRate, _totalSupplyTimestamp);
  }

  /**
   * @dev returns the the total supply and the average stable rate
   **/
  function getTotalSupplyAndAvgRate() public override view returns (uint256, uint256) {
    uint256 avgRate = _avgStableRate;
    return (_calcTotalSupply(avgRate), avgRate);
  }

  /**
   * @dev returns the total supply
   **/
  function totalSupply() public override view returns (uint256) {
    return _calcTotalSupply(_avgStableRate);
  }

  /**
   * @dev returns the timestamp at which the total supply was updated
   **/
  function getTotalSupplyLastUpdated() public override view returns(uint40) {
    return _totalSupplyTimestamp;
  }

  /**
   * @dev Returns the principal debt balance of the user from
   * @param user the user
   * @return The debt balance of the user since the last burn/mint action
   **/
  function principalBalanceOf(address user) external virtual override view returns (uint256) {
    return super.balanceOf(user);
  }


  /**
   * @dev calculates the total supply 
   * @param avgRate the average rate at which calculate the total supply
   * @return The debt balance of the user since the last burn/mint action
   **/
  function _calcTotalSupply(uint256 avgRate) internal view returns(uint256) {
    uint256 principalSupply = super.totalSupply();

    if (principalSupply == 0) {
      return 0;
    }

    uint256 cumulatedInterest = MathUtils.calculateCompoundedInterest(
      avgRate,
      _totalSupplyTimestamp
    );

    return principalSupply.rayMul(cumulatedInterest);
  }

   /**
   * @dev mints stable debt tokens to an user
   * @param account the account receiving the debt tokens
   * @param amount the amount being minted
   * @param oldTotalSupply the total supply before the minting event
   **/
   function _mint(address account, uint256 amount, uint256 oldTotalSupply) internal {

    uint256 oldAccountBalance = _balances[account];
    _balances[account] = oldAccountBalance.add(amount);

    if (address(_incentivesController) != address(0)) {
      _incentivesController.handleAction(account, oldTotalSupply, oldAccountBalance);
    }
  }

   /**
   * @dev burns stable debt tokens of an user
   * @param account the user getting his debt burned
   * @param amount the amount being burned
   * @param oldTotalSupply the total supply before the burning event
   **/
  function _burn(address account, uint256 amount, uint256 oldTotalSupply) internal {
 
    uint256 oldAccountBalance = _balances[account];
    _balances[account] = oldAccountBalance.sub(amount, 'ERC20: burn amount exceeds balance');

    if (address(_incentivesController) != address(0)) {
      _incentivesController.handleAction(account, oldTotalSupply, oldAccountBalance);
    }
  }
}
