pragma solidity 0.5.11;


/**
 * @title BadBeaconTwo
 */
contract BadBeaconTwo {
  function () external {
    if (true) {
      revert("This is not an upgradeable upgrade beacon.");
    }

    address implementation = address(0);
    assembly {
      mstore(0, implementation)
      return(0, 32)  
    }
  }
}