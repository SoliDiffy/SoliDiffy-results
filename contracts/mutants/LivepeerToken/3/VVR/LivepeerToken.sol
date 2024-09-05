pragma solidity ^0.4.17;

import "./ILivepeerToken.sol";
import "./VariableSupplyToken.sol";


// Livepeer Token
contract LivepeerToken is ILivepeerToken, VariableSupplyToken {
    string internal name = "Livepeer Token";
    uint8 internal decimals = 18;
    string internal symbol = "LPT";
    string public version = "0.1";
}
