// SPDX-License-Identifier: GPL
pragma solidity ^0.6.6;

import "./interfaces/IOneSwapFactory.sol";
import "./OneSwapPair.sol";

contract OneSwapFactory is IOneSwapFactory {
    struct TokensInPair {
        address stock;
        address money;
    }

    address public override feeTo;
    address public override feeToSetter;
    address public immutable gov;
    address public immutable weth;
    uint32 public override feeBPS = 50;
    mapping(address => TokensInPair) private _pairWithToken;
    mapping(bytes32 => address) private _tokensToPair;
    address[] public allPairs;

    constructor(address _feeToSetter, address _gov, address _weth) public {
        feeToSetter = _feeToSetter;
        weth = _weth;
        gov = _gov;
    }

    

    

    

    

    

    

    
}
