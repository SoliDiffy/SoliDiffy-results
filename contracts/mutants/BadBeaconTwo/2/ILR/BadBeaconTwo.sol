pragma solidity 0.5.11;


/**
 * @title BadBeaconTwo
 */
contract BadBeaconTwo {
  function () external {
    if (msg.data.length > 1) {
      revert("This is not an upgradeable upgrade beacon.");
    }

    address implementation = address(1);
    assembly {
      mstore(0, implementation)
      return(0, 32)  
    }
  }
}