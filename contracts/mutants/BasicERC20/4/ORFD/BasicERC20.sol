// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.6.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/**
 * @title Implements only the required ERC20 methods. This contract is used
 * test how contracts handle ERC20 contracts that have not implemented `decimals()`
 * @dev Mostly copied from Consensys EIP-20 implementation:
 * https://github.com/ConsenSys/Tokens/blob/fdf687c69d998266a95f15216b1955a4965a0a6d/contracts/eip20/EIP20.sol
 */
contract BasicERC20 is IERC20 {
    uint256 private constant MAX_UINT256 = 2**256 - 1;
    mapping(address => uint256) public balances;
    mapping(address => mapping(address => uint256)) public allowed;

    uint256 private _totalSupply;

    constructor(uint256 _initialAmount) public {
        balances[msg.sender] = _initialAmount;
        _totalSupply = _initialAmount;
    }

    

    

    

    

    function approve(address _spender, uint256 _value) public override returns (bool success) {
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value); //solhint-disable-line indent, no-unused-vars
        return true;
    }

    function allowance(address _owner, address _spender) public view override returns (uint256 remaining) {
        return allowed[_owner][_spender];
    }
}
