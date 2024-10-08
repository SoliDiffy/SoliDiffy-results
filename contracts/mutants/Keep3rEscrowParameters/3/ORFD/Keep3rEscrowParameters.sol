// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;

import '../../../keep3r/escrow/Keep3rEscrowParameters.sol';

contract Keep3rEscrowParametersMock is Keep3rEscrowParameters {
  constructor(
    address _governance,
    IKeep3rV1 _keep3r,
    IERC20 _lpToken
  ) public Keep3rEscrowParameters(_governance, _keep3r, _lpToken) {}

  

  

  

  function setLPToken(IERC20 _lpToken) public override {
    _setLPToken(_lpToken);
  }
}
