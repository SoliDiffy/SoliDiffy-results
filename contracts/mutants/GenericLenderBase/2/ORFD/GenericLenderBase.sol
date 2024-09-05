// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.6.12;

import {VaultAPI} from "@yearnvaults/contracts/BaseStrategy.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";

import "./IGenericLender.sol";

interface IBaseStrategy {
    function apiVersion() external pure returns (string memory);

    function name() external pure returns (string memory);

    function vault() external view returns (address);

    function keeper() external view returns (address);

    function tendTrigger(uint256 callCost) external view returns (bool);

    function tend() external;

    function harvestTrigger(uint256 callCost) external view returns (bool);

    function harvest() external;

    function strategist() external view returns (address);
}

abstract contract GenericLenderBase is IGenericLender {
    VaultAPI public vault;
    address public override strategy;
    IERC20 public want;
    string public override lenderName;

    uint256 public dust;

    constructor(address _strategy, string memory name) public {
        strategy = _strategy;
        vault = VaultAPI(IBaseStrategy(strategy).vault());
        want = IERC20(vault.token());
        lenderName = name;
        dust = 10000;

        want.approve(_strategy, uint256(-1));
    }

    

    

    function protectedTokens() internal view virtual returns (address[] memory);

    //make sure to use
    modifier management() {
        require(
            msg.sender == address(strategy) || msg.sender == vault.governance() || msg.sender == IBaseStrategy(strategy).strategist(),
            "!management"
        );
        _;
    }
}
