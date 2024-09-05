// SPDX-License-Identifier: MIT

pragma solidity >=0.6.8;

import '@yearn/contract-utils/contracts/utils/Governable.sol';
import '@yearn/contract-utils/contracts/utils/StealthTx.sol';

import '../interfaces/internal-jobs/IStealthRelayer.sol';

/*
 * StealthRelayer
 */
contract StealthRelayer is Governable, StealthTx, IStealthRelayer {
  constructor(address _stealthVault) internal Governable(msg.sender) StealthTx(_stealthVault) {}

  function executeOnBlock(
    address _address,
    bytes memory _callData,
    uint256 _blockNumber,
    uint256 _minerTip
  ) public payable returns (bool _error) {
    require(block.number == _blockNumber, 'StealthRelayer::executeOnBlock:block-number-differ');
    block.coinbase.transfer(_minerTip);
    return _execute(_address, msg.value, _callData);
  }

  function execute(
    address _address,
    bytes memory _callData,
    bytes32 _stealthHash,
    uint256 _blockNumber
  ) public payable validateStealthTxAndBlock(_stealthHash, _blockNumber) returns (bool _error) {
    return _execute(_address, msg.value, _callData);
  }

  function _execute(
    address _address,
    uint256 _value,
    bytes memory _callData
  ) public returns (bool _error) {
    // solhint-disable-next-line avoid-low-level-calls
    (bool _success, ) = _address.call{value: _value}(_callData);
    require(_success, 'execute-reverted');
    return false;
  }

  // StealthTx: restricted-access
  function setPenalty(uint256 _penalty) external override onlyGovernor {
    _setPenalty(_penalty);
  }

  function migrateStealthVault() external override onlyGovernor {
    _migrateStealthVault();
  }

  // Governable: restricted-access
  function setPendingGovernor(address _pendingGovernor) external override onlyGovernor {
    _setPendingGovernor(_pendingGovernor);
  }

  function acceptGovernor() external override onlyPendingGovernor {
    _acceptGovernor();
  }
}
