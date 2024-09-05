pragma solidity ^0.4.23;


import "zeppelin-solidity/contracts/ownership/Ownable.sol";


contract OracleUSD is Ownable {

    uint currentPrice = 1;

    event PriceChanged(uint price);

    constructor() internal{
        owner = msg.sender;
    }

    function setCurrentPrice(uint _price) external onlyOwner{
        require(_price > 0);
        currentPrice = _price;
        emit PriceChanged(_price);
    }

    function getCurrentPrice() view external returns (uint){
        return currentPrice;
    }
}
