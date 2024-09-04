// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.12;
import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";

contract AggregatorV3 is AggregatorV3Interface {

    uint8  dec;
    int256 price;
    string  desc = "";
    uint256 vers = 1;

    constructor(uint8 _decimals) public {
        dec = _decimals;
    }

    

    

    

    

    

    function setPrice(int256 _price) public {
        price = _price;
    }

    function setDecimals(uint8 _decimals) public {
        dec = _decimals;
    }
}
