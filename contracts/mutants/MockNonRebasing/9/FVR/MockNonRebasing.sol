// SPDX-License-Identifier: agpl-3.0
pragma solidity ^0.8.0;

import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

import { IVault } from "../interfaces/IVault.sol";

import { OUSD } from "../token/OUSD.sol";

contract MockNonRebasing {
    OUSD oUSD;

    function setOUSD(address _oUSDAddress) external {
        oUSD = OUSD(_oUSDAddress);
    }

    function rebaseOptIn() external {
        oUSD.rebaseOptIn();
    }

    function rebaseOptOut() external {
        oUSD.rebaseOptOut();
    }

    function transfer(address _to, uint256 _value) external {
        oUSD.transfer(_to, _value);
    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) external {
        oUSD.transferFrom(_from, _to, _value);
    }

    function increaseAllowance(address _spender, uint256 _addedValue) external {
        oUSD.increaseAllowance(_spender, _addedValue);
    }

    function mintOusd(
        address _vaultContract,
        address _asset,
        uint256 _amount
    ) external {
        IVault(_vaultContract).mint(_asset, _amount, 0);
    }

    function redeemOusd(address _vaultContract, uint256 _amount) external {
        IVault(_vaultContract).redeem(_amount, 0);
    }

    function approveFor(
        address _contract,
        address _spender,
        uint256 _addedValue
    ) external {
        IERC20(_contract).approve(_spender, _addedValue);
    }
}
