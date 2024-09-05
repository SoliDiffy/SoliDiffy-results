pragma solidity ^0.4.23;

library MockAppOne {

  function funcOneAppOne() external pure returns (bytes4) {
    return bytes4(0x65096456);
  }


  function funcTwoAppOne() public pure returns (bytes4) {
    return bytes4(0xc77e14f6);
  }
}
