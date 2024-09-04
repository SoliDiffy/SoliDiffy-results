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
