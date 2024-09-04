// SPDX-License-Identifier: MIT
pragma solidity ^0.7.1;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";
import "diamond-2/contracts/libraries/LibDiamond.sol";

import "../../interfaces/IERC20Facet.sol";
import "./LibERC20Storage.sol";
import "./LibERC20.sol";
import "../shared/Access/CallProtection.sol";

contract ERC20Facet is IERC20, IERC20Facet, CallProtection {
  using SafeMath for uint256;

  

  

  

  

  

  

  // SWC-114-Transaction Order Dependence: L53 - L61
  

  

  function transferFrom(
    address _from,
    address _to,
    uint256 _amount
  ) external override returns (bool) {
    LibERC20Storage.ERC20Storage storage es = LibERC20Storage.erc20Storage();

    // Update approval if not set to max uint256
    if (es.allowances[_from][msg.sender] != uint256(-1)) {
      uint256 newApproval = es.allowances[_from][msg.sender].sub(_amount);
      es.allowances[_from][msg.sender] = newApproval;
      emit Approval(_from, msg.sender, newApproval);
    }

    _transfer(_from, _to, _amount);
  }

  function allowance(address _owner, address _spender)
    external
    view
    override
    returns (uint256)
  {
    return LibERC20Storage.erc20Storage().allowances[_owner][_spender];
  }

  function balanceOf(address _of) external view override returns (uint256) {
    return LibERC20Storage.erc20Storage().balances[_of];
  }

  function totalSupply() external view override returns (uint256) {
    return LibERC20Storage.erc20Storage().totalSupply;
  }

  function _transfer(
    address _from,
    address _to,
    uint256 _amount
  ) internal {
    if (_to == address(0)) {
      return LibERC20.burn(msg.sender, _amount);
    }
    LibERC20Storage.ERC20Storage storage es = LibERC20Storage.erc20Storage();

    es.balances[_from] = es.balances[_from].sub(_amount);
    es.balances[_to] = es.balances[_to].add(_amount);

    emit Transfer(_from, _to, _amount);
  }
}