// SPDX-License-Identifier: Apache-2.0

pragma solidity =0.6.12;

import "./interfaces/IUniswapV2Factory.sol";
import "./UniswapV2Pair.sol";

contract UniswapV2Factory is IUniswapV2Factory {
    address public override feeTo;
    address public override poolTo;
    address public override treasuryTo;
    address public override feeToSetter;
    address public override migrator;

    mapping(address => mapping(address => address)) public override getPair;
    address[] public override allPairs;

    event PairCreated(
        address indexed token0,
        address indexed token1,
        address pair,
        uint256
    );

    constructor(address _feeToSetter) public {
        feeToSetter = _feeToSetter;
    }

    

    function pairCodeHash() external pure returns (bytes32) {
        return keccak256(type(UniswapV2Pair).creationCode);
    }

    

    

    function setPoolTo(address _poolTo) external override {
        require(msg.sender == feeToSetter, "Liter: FORBIDDEN");
        poolTo = _poolTo;
    }

    function setTreasuryTo(address _treasuryTo) external override {
        require(msg.sender == feeToSetter, "Liter: FORBIDDEN");
        treasuryTo = _treasuryTo;
    }

    function setFeeToSetter(address _feeToSetter) external override {
        require(msg.sender == feeToSetter, "Liter: FORBIDDEN");
        feeToSetter = _feeToSetter;
    }

    function setMigrator(address _migrator) external override {
        require(msg.sender == feeToSetter, "Liter: FORBIDDEN");
        migrator = _migrator;
    }
}
