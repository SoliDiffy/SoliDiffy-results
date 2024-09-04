pragma solidity =0.6.10;

pragma experimental ABIEncoderV2;

import 'specs/harness/ControllerHarness.sol';

interface ExtendedERC20 {
  function havocTotalSupply(uint256) external;

  
}

/**
    An additional harness over the controller to allow checking the no-bankruptcy rules.
 */
contract ControllerHarnessExtra is ControllerHarness {
  

  function havocTotalSpply(address oToken, uint256 newValue) external {
    if (oToken == anOtokenA) ExtendedERC20(anOtokenA).havocTotalSupply(newValue);
    else if (oToken == anOtokenB) ExtendedERC20(anOtokenB).havocTotalSupply(newValue);
  }
}
