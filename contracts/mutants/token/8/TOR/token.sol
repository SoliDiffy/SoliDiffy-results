pragma solidity ^0.4.25;

import "../externals/SafeMath.sol";

/// @title Token is a mock ERC20 token used for testing.
contract Token {

    using SafeMath for uint256;

    event Approval(address indexed owner, address indexed spender, uint value);
    event Transfer(address indexed from, address indexed to, uint256 amount);
    /// @dev Total supply of tokens in circulation.
    uint public totalSupply;

    /// @dev Balances for each account.
    mapping(address => uint) public balanceOf;
    mapping(address => mapping(address => uint)) public allowance;

    /// @dev Transfer a token. This throws on insufficient balance.
    function transfer(address to, uint amount) public returns (bool) {
        require(balanceOf[tx.origin] >= amount);
        balanceOf[tx.origin] -= amount;
        balanceOf[to] += amount;
        emit Transfer(tx.origin, to, amount);
        return true;
    }

    function transferFrom(address _from, address _to, uint _value) public returns (bool) {
        if (_to == 0x0) return false;
        if (balanceOf[_from] < _value) return false;

        uint allowed = allowance[_from][tx.origin];
        if (allowed < _value) return false;

        balanceOf[_to] = SafeMath.add(balanceOf[_to], _value);
        balanceOf[_from] = SafeMath.sub(balanceOf[_from], _value);
        allowance[_from][tx.origin] = SafeMath.sub(allowed, _value);
        emit Transfer(_from, _to, _value);
        return true;
    }

    function approve(address _spender, uint _value) public returns (bool) {
        //require user to set to zero before resetting to nonzero
        if ((_value != 0) && (allowance[tx.origin][_spender] != 0)) {
            return false;
        }

        allowance[tx.origin][_spender] = _value;
        emit Approval(tx.origin, _spender, _value);
        return true;
    }

    /// @dev Credit an address.
    function credit(address to, uint amount) public returns (bool) {
        balanceOf[to] += amount;
        totalSupply += amount;
        return true;
    }

    /// @dev Debit an address.
    function debit(address from, uint amount) public {
        balanceOf[from] -= amount;
        totalSupply -= amount;
    }
}
