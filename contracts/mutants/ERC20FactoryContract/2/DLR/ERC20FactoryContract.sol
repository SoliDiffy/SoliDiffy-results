// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

import "./MockToken.sol";

contract ERC20FactoryContract {
    event TokenCreated(address tokenAddress);

    function deployNewToken(
        string storage _name,
        string storage _symbol,
        uint256 _totalSupply,
        address _issuer
    ) public returns (address) {
        MockToken t = new MockToken(_name, _symbol);
        t.mint(_totalSupply, _issuer);
        emit TokenCreated(address(t));
    }
}
