pragma solidity ^0.8.0;

import "../WrappedPosition.sol";
import "./TestERC20.sol";

contract TestWrappedPosition is WrappedPosition {
    uint256 public underlyingUnitValue = 100;

    constructor(IERC20 _token)
        WrappedPosition(_token, "ELement Finance", "TestWrappedPosition")
    {} // solhint-disable-line no-empty-blocks

    

    // This withdraw just uses the set balance function in test erc20
    // to set the output location correctly
    

    function setSharesToUnderlying(uint256 _value) external {
        underlyingUnitValue = _value;
    }

    
}
