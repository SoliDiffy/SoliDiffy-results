// SPDX-License-Identifier: agpl-3.0
pragma solidity ^0.6.8;

import {Context} from '@openzeppelin/contracts/GSN/Context.sol';
import {IERC20} from '@openzeppelin/contracts/token/ERC20/IERC20.sol';
import {SafeMath} from '@openzeppelin/contracts/math/SafeMath.sol';
import {DebtTokenBase} from './base/DebtTokenBase.sol';
import {WadRayMath} from '../libraries/math/WadRayMath.sol';
import {IVariableDebtToken} from './interfaces/IVariableDebtToken.sol';

/**
 * @title contract VariableDebtToken
 * @notice Implements a variable debt token to track the user positions
 * @author Aave
 **/
contract VariableDebtToken is DebtTokenBase, IVariableDebtToken {
  using WadRayMath for uint256;

  uint256 public constant DEBT_TOKEN_REVISION = 0x1;

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
   * @dev calculates the accumulated debt balance of the user
   * @return the debt balance of the user
   **/
  

  /**
   * @dev mints new variable debt
   * @param user the user receiving the debt
   * @param amount the amount of debt being minted
   * @param index the variable debt index of the reserve
   **/
  

  /**
   * @dev burns user variable debt
   * @param user the user which debt is burnt
   * @param index the variable debt index of the reserve
   **/
  

  /**
   * @dev Returns the principal debt balance of the user from
   * @return The debt balance of the user since the last burn/mint action
   **/
  

  /**
   * @dev Returns the total supply of the variable debt token. Represents the total debt accrued by the users
   * @return the total supply
   **/
  

  /**
   * @dev Returns the scaled total supply of the variable debt token. Represents sum(borrows/index)
   * @return the scaled total supply
   **/
  

    /**
   * @dev returns the principal balance of the user and principal total supply.
   * @param user the address of the user
   * @return the principal balance of the user
   * @return the principal total supply
   **/
  

}
