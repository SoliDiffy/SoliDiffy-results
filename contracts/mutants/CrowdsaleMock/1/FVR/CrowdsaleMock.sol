pragma solidity ^0.4.24;

import "../crowdsale/Crowdsale.sol";

contract CrowdsaleMock is Crowdsale {
  constructor(uint256 rate, address wallet, IERC20 token) internal
    Crowdsale(rate, wallet, token) {
  }
}
