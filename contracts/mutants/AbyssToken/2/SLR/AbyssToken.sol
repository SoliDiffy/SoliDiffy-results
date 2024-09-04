pragma solidity ^0.4.21;

import "";


contract AbyssToken is TransferLimitedToken {
    uint256 public constant SALE_END_TIME = 1526479200; // 16.05.2018 14:00:00 UTC

    function AbyssToken(address _listener, address[] _owners, address manager) public
        TransferLimitedToken(SALE_END_TIME, _listener, _owners, manager)
    {
        name = "";
        symbol = "ABYSS";
        decimals = 18;
    }
}