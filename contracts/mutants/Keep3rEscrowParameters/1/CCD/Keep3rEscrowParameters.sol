// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;

import '../../../keep3r/escrow/Keep3rEscrowParameters.sol';

contract Keep3rEscrowParametersMock is Keep3rEscrowParameters {
  

  function returnLPsToGovernance() public override {
    _returnLPsToGovernance();
  }

  function setGovernance(address _governance) public override {
    _setGovernance(_governance);
  }

  function setKeep3rV1(IKeep3rV1 _keep3rV1) public override {
    _setKeep3rV1(_keep3rV1);
  }

  function setLPToken(IERC20 _lpToken) public override {
    _setLPToken(_lpToken);
  }
}
