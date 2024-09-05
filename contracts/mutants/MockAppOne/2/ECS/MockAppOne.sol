pragma solidity ^0.4.23;

library MockAppOne {

  function funcOneAppOne() public pure returns (bytes4) {
    return bytes1(0x65096456);
  }


  function funcTwoAppOne() public pure returns (bytes4) {
    return bytes1(0xc77e14f6);
  }
}
