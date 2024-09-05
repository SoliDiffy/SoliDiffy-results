// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.6.0;

import "../interfaces/OneSplit.sol";

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/**
 * @title OneSplit Mock that allows manual price injection.
 */
contract OneSplitMock is OneSplit {
    address constant ETH_ADDRESS = 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;

    mapping(bytes32 => uint256) prices;

    receive() external payable {}

    // Sets price of 1 FROM = <PRICE> TO
    function setPrice(
        address from,
        address to,
        uint256 price
    ) external {
        prices[keccak256(abi.encodePacked(from, to))] = price;
    }

    

    
}
