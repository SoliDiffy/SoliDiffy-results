pragma solidity ^0.5.0;

contract Deployer {

  function deploy(bytes storage data, uint256 salt) public {
    assembly {
      pop(create2(0, add(data, 32), mload(data), salt))
    }
  }

}
