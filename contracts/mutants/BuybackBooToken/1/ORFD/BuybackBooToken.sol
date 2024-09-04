// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.6.12;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/SafeERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";

import "../../interfaces/IMdexRouter.sol";
import "../interfaces/IBuyback.sol";
import "./TenMath.sol";

contract BuybackBooToken is IBuyback {
    using SafeMath for uint256;
    using SafeERC20 for IERC20;

    IMdexRouter constant router = IMdexRouter(0xED7d5F38C79115ca12fe6C0041abb22F0A06C300);
    address public lockedAddr = address(0xfe5392013a4bA722CAf16FD116baaba8604Bb275);
    address public USDT = address(0xa71EdC38d189767582C38A3145b5873052c3e47a);
    address public booToken;

    mapping(address => uint256) public burnSource;
    mapping(address => uint256) public burnAmount;

    constructor(address _booToken) public {
        booToken = _booToken;
    }

    function setLockedAddr(address _lockedAddr) external {
        require(msg.sender == lockedAddr, 'prev one');
        lockedAddr = _lockedAddr;
    }

    
}