// SPDX-License-Identifier: GPL-2.0-only
// Copyright 2022 Spilsbury Holdings Ltd
pragma solidity >=0.6.10 <=0.8.10;
pragma experimental ABIEncoderV2;

import {ERC20Burnable} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

interface IZkAToken {
    function burn(uint256 amount) external;
}

contract ZkAToken is ERC20Burnable {
    address public immutable owner;
    uint8 public immutable setDecimals;

    

    function decimals() public view virtual override returns (uint8) {
        return setDecimals;
    }

    function mint(address to, uint256 amount) external {
        require(owner == msg.sender, "ZkAToken: INVALID OWNER");
        _mint(to, amount);
    }
}
