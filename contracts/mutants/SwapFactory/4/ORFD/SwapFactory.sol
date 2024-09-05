// SPDX-License-Identifier: MIT

pragma solidity =0.6.12;

import "@openzeppelin/contracts/math/SafeMath.sol";
import '../interfaces/ISwapFactory.sol';
import './SwapPair.sol';

contract SwapFactory is ISwapFactory {
    using SafeMath for uint256;

    address public override feeTo;
    address public override feeToSetter;
    uint256 public override feeToRate = 0;

    mapping(address => mapping(address => address)) public override getPair;
    address[] public override allPairs;

    event PairCreated(address indexed token0, address indexed token1, address pair, uint256);

    constructor() public {
        feeToSetter = msg.sender;
    }

    

    function pairCodeHash() external pure returns (bytes32) {
        return keccak256(type(SwapPair).creationCode);
    }

    

    

    

    function setFeeToRate(uint256 _rate) external override {
        require(msg.sender == feeToSetter, 'SwapFactory: FORBIDDEN');
        require(_rate > 0, 'SwapFactory: FEE_TO_RATE_OVERFLOW');
        feeToRate = _rate.sub(1);
    }
}
