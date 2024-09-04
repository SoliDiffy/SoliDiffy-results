// SPDX-License-Identifier: MIT
pragma experimental ABIEncoderV2;
pragma solidity ^0.7.1;

import "diamond-2/contracts/libraries/LibDiamond.sol";
import "../../interfaces/ICallFacet.sol";
import "../shared/Reentry/ReentryProtection.sol";
import "../shared/Access/CallProtection.sol";
import "./LibCallStorage.sol";

contract CallFacet is ReentryProtection, ICallFacet {

  // uses modified call protection modifier to also allow whitelisted addresses to call
  modifier protectedCall() {
    require(
        msg.sender == LibDiamond.diamondStorage().contractOwner ||
        LibCallStorage.callStorage().canCall[msg.sender] ||
        msg.sender == address(this), "NOT_ALLOWED"
    );
    _;
  }

  

  

  

  function callNoValue(
    address[] memory _targets,
    bytes[] memory _calldata
  ) public override noReentry protectedCall {
    require(
      _targets.length == _calldata.length,
      "ARRAY_LENGTH_MISMATCH"
    );

    // SWC-128-DoS With Block Gas Limit: L84 - L86
    for (uint256 i = 0; i < _targets.length; i++) {
      _call(_targets[i], _calldata[i], 0);
    }
  }

  function singleCall(
    address _target,
    bytes calldata _calldata,
    uint256 _value
  ) external override noReentry protectedCall {
    _call(_target, _calldata, _value);
  }

  function _call(
    address _target,
    bytes memory _calldata,
    uint256 _value
  ) internal {
    (bool success, ) = _target.call{ value: _value }(_calldata);
    require(success, "CALL_FAILED");
    emit Call(_target, _calldata, _value);
  }

  function canCall(address _caller) external view override returns (bool) {
    return LibCallStorage.callStorage().canCall[_caller];
  }

  function getCallers() external view override returns (address[] memory) {
    return LibCallStorage.callStorage().callers;
  }
}
