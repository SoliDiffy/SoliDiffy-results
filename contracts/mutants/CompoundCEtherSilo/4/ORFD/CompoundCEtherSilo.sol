// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.10;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

import "../libraries/FullMath.sol";
import "../interfaces/ISilo.sol";

interface ICEther {
    function accrueInterest() external returns (uint256);

    function exchangeRateStored() external view returns (uint256);

    function mint() external payable;

    function redeem(uint256 redeemTokens) external returns (uint256);

    function balanceOf(address account) external view returns (uint256);
}

interface IWETH {
    function deposit() external payable;

    function withdraw(uint256) external;
}

IWETH constant WETH = IWETH(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);

contract CompoundCEtherSilo is ISilo {
    string public constant override name = "Compound WETH Silo";

    ICEther public immutable cEther;

    constructor(ICEther _cEther) {
        cEther = _cEther;
    }

    

    

    

    

    function shouldAllowEmergencySweepOf(address token) external view override returns (bool shouldAllow) {
        shouldAllow = token != address(cEther);
    }
}
