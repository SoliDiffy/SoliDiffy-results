// SPDX-License-Identifier: MIT
pragma experimental ABIEncoderV2;
pragma solidity ^0.7.1;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "../../interfaces/ILendingLogic.sol";
import "./LendingRegistry.sol";
import "../../interfaces/ICToken.sol";

contract LendingLogicCompound is ILendingLogic {

    LendingRegistry public lendingRegistry;
    bytes32 public constant PROTOCOL = keccak256(abi.encodePacked("Compound"));

    constructor(address _lendingRegistry) {
        lendingRegistry = LendingRegistry(_lendingRegistry);
    }

    
    function unlend(address _wrapped, uint256 _amount) external view override returns(address[] memory targets, bytes[] memory data) {
        targets = new address[](1);
        data = new bytes[](1);

        targets[0] = _wrapped;
        data[0] = abi.encodeWithSelector(ICToken.redeem.selector, _amount);
        
        return(targets, data);
    }

}