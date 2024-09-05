// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

import "../interfaces/IProvider.sol";
import "../interfaces/IWETH.sol";
import "../interfaces/IFujiMappings.sol";
import "../interfaces/compound/IGenCToken.sol";
import "../interfaces/compound/ICErc20.sol";
import "../interfaces/compound/IComptroller.sol";
import "../libraries/LibUniversalERC20.sol";

contract HelperFunct {
  function _isETH(address token) internal pure returns (bool) {
    return (token == address(0) || token == address(0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE));
  }

  function _getMappingAddr() internal pure returns (address) {
    return 0x17525aFdb24D24ABfF18108E7319b93012f3AD24;
  }

  function _getComptrollerAddress() internal pure returns (address) {
    return 0xAB1c342C7bf5Ec5F02ADEA1c2270670bCa144CbB;
  }

  //IronBank functions

  /**
   * @dev Approves vault's assets as collateral for IronBank Protocol.
   * @param _cyTokenAddress: asset type to be approved as collateral.
   */
  function _enterCollatMarket(address _cyTokenAddress) internal {
    // Create a reference to the corresponding network Comptroller
    IComptroller comptroller = IComptroller(_getComptrollerAddress());

    address[] memory cyTokenMarkets = new address[](1);
    cyTokenMarkets[0] = _cyTokenAddress;
    comptroller.enterMarkets(cyTokenMarkets);
  }

  /**
   * @dev Removes vault's assets as collateral for IronBank Protocol.
   * @param _cyTokenAddress: asset type to be removed as collateral.
   */
  function _exitCollatMarket(address _cyTokenAddress) internal {
    // Create a reference to the corresponding network Comptroller
    IComptroller comptroller = IComptroller(_getComptrollerAddress());

    comptroller.exitMarket(_cyTokenAddress);
  }
}

contract ProviderIronBank is IProvider, HelperFunct {
  using LibUniversalERC20 for IERC20;

  //Provider Core Functions

  /**
   * @dev Deposit ETH/ERC20_Token.
   * @param _asset: token address to deposit. (For ETH: 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE)
   * @param _amount: token amount to deposit.
   */
  

  /**
   * @dev Withdraw ETH/ERC20_Token.
   * @param _asset: token address to withdraw. (For ETH: 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE)
   * @param _amount: token amount to withdraw.
   */
  

  /**
   * @dev Borrow ETH/ERC20_Token.
   * @param _asset token address to borrow.(For ETH: 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE)
   * @param _amount: token amount to borrow.
   */
  

  /**
   * @dev Payback borrowed ETH/ERC20_Token.
   * @param _asset token address to payback.(For ETH: 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE)
   * @param _amount: token amount to payback.
   */
  

  /**
   * @dev Returns the current borrowing rate (APR) of a ETH/ERC20_Token, in ray(1e27).
   * @param _asset: token address to query the current borrowing rate.
   */
  

  /**
   * @dev Returns the borrow balance of a ETH/ERC20_Token.
   * @param _asset: token address to query the balance.
   */
  

  /**
   * @dev Return borrow balance of ETH/ERC20_Token.
   * This function is the accurate way to get IronBank borrow balance.
   * It costs ~84K gas and is not a view function.
   * @param _asset token address to query the balance.
   * @param _who address of the account.
   */
  

  /**
   * @dev Returns the deposit balance of a ETH/ERC20_Token.
   * @param _asset: token address to query the balance.
   */
  
}
