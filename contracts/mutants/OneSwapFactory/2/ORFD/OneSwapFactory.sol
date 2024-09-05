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

    

    

    function setFeeTo(address _feeTo) external override {
        require(msg.sender == feeToSetter, "OneSwapFactory: FORBIDDEN");
        feeTo = _feeTo;
    }

    function setFeeToSetter(address _feeToSetter) external override {
        require(msg.sender == feeToSetter, "OneSwapFactory: FORBIDDEN");
        feeToSetter = _feeToSetter;
    }

    function setFeeBPS(uint32 _bps) external override {
        require(msg.sender == gov, "OneSwapFactory: SETTER_MISMATCH");
        require(0 <= _bps && _bps <= 50 , "OneSwapFactory: BPS_OUT_OF_RANGE");
        feeBPS = _bps;
    }

    function getTokensFromPair(address pair) external view override returns (address stock, address money) {
        stock = _pairWithToken[pair].stock;
        money = _pairWithToken[pair].money;
    }

    function tokensToPair(address stock, address money, bool isOnlySwap) external view override returns (address pair){
        bytes32 key = keccak256(abi.encodePacked(stock, money, isOnlySwap));
        return _tokensToPair[key];
    }
}
