pragma solidity ^0.5.0;

import "../../modules/cover/Gateway.sol";

contract DisposableGateway is Gateway {

  function initialize(address masterAddress, address daiAddress) public {
    master = INXMMaster(masterAddress);
    DAI = daiAddress;
  }
}
