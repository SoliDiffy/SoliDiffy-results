// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;

import '@openzeppelin/contracts/token/ERC20/IERC20.sol';
import '@yearn/contract-utils/contracts/abstract/MachineryReady.sol';
import '@yearn/contract-utils/contracts/interfaces/keep3r/IKeep3rV1.sol';

import '../proxy-job/Keep3rJob.sol';
import '../interfaces/jobs/IKeep3rEscrowJob.sol';

import '../interfaces/keep3r/IKeep3rEscrow.sol';

contract Keep3rEscrowJob is MachineryReady, Keep3rJob, IKeep3rEscrowJob {
  IKeep3rV1 public Keep3rV1;
  IERC20 public Liquidity;

  IKeep3rEscrow public Escrow1;
  IKeep3rEscrow public Escrow2;

  constructor(
    address _mechanicsRegistry,
    address _keep3r,
    address _keep3rProxyJob,
    address _liquidity,
    address _escrow1,
    address _escrow2
  ) public MachineryReady(_mechanicsRegistry) Keep3rJob(_keep3rProxyJob) {
    Keep3rV1 = IKeep3rV1(_keep3r);
    Liquidity = IERC20(_liquidity);
    Escrow1 = IKeep3rEscrow(_escrow1);
    Escrow2 = IKeep3rEscrow(_escrow2);
  }

  // Keep3rV1 Escrow helper
  

  // Job actions (not relevant to this job, but added to maintain consistency)
  

  function decodeWorkData(bytes memory _workData) public pure {
    _workData; // shh
    return;
  }

  // Keep3r actions
  

  function _workable(Actions _action) internal pure returns (bool) {
    return (_action != Actions.none);
  }

  

  // Governor escrow bypass
  

  function _work(IKeep3rEscrow Escrow, Actions _action) internal {
    if (_action == Actions.addLiquidityToJob) {
      uint256 _amount = Liquidity.balanceOf(address(Escrow));
      Escrow.addLiquidityToJob(address(Liquidity), address(Keep3rProxyJob), _amount);
      return;
    }

    if (_action == Actions.applyCreditToJob) {
      IKeep3rEscrow OtherEscrow = address(Escrow) == address(Escrow1) ? Escrow2 : Escrow1;

      // ALWAYS FIRST: Should try to unbondLiquidityFromJob from OtherEscrow
      uint256 _liquidityProvided = Keep3rV1.liquidityProvided(address(OtherEscrow), address(Liquidity), address(Keep3rProxyJob));
      uint256 _liquidityAmount = Keep3rV1.liquidityAmount(address(OtherEscrow), address(Liquidity), address(Keep3rProxyJob));
      if (_liquidityProvided > 0 && _liquidityAmount == 0) {
        OtherEscrow.unbondLiquidityFromJob(address(Liquidity), address(Keep3rProxyJob), _liquidityProvided);
      } else {
        //  - if can't unbound then addLiquidity
        uint256 _amount = Liquidity.balanceOf(address(OtherEscrow));
        if (_amount > 0) {
          OtherEscrow.addLiquidityToJob(address(Liquidity), address(Keep3rProxyJob), _amount);
        } else {
          //      - if no liquidity to add and liquidityAmountsUnbonding then removeLiquidityFromJob + addLiquidityToJob
          uint256 _liquidityAmountsUnbonding = Keep3rV1.liquidityAmountsUnbonding(
            address(OtherEscrow),
            address(Liquidity),
            address(Keep3rProxyJob)
          );
          uint256 _liquidityUnbonding = Keep3rV1.liquidityUnbonding(address(OtherEscrow), address(Liquidity), address(Keep3rProxyJob));
          if (_liquidityAmountsUnbonding > 0 && _liquidityUnbonding < block.timestamp) {
            OtherEscrow.removeLiquidityFromJob(address(Liquidity), address(Keep3rProxyJob));
            _amount = Liquidity.balanceOf(address(OtherEscrow));
            OtherEscrow.addLiquidityToJob(address(Liquidity), address(Keep3rProxyJob), _amount);
          }
        }
      }

      // Run applyCreditToJob
      Escrow.applyCreditToJob(address(Escrow), address(Liquidity), address(Keep3rProxyJob));
      return;
    }

    if (_action == Actions.removeLiquidityFromJob) {
      Escrow.removeLiquidityFromJob(address(Liquidity), address(Keep3rProxyJob));
      uint256 _amount = Liquidity.balanceOf(address(Escrow));
      Escrow.addLiquidityToJob(address(Liquidity), address(Keep3rProxyJob), _amount);
      return;
    }
  }

  

  

  

  function unbondLiquidityFromJob(address _escrow) external override onlyGovernorOrMechanic {
    require(_escrow == address(Escrow1) || _escrow == address(Escrow2), 'Keep3rEscrowJob::unbondLiquidityFromJob:invalid-escrow');
    IKeep3rEscrow Escrow = IKeep3rEscrow(_escrow);
    uint256 _amount = Keep3rV1.liquidityProvided(address(Escrow), address(Liquidity), address(Keep3rProxyJob));
    Escrow.unbondLiquidityFromJob(address(Liquidity), address(Keep3rProxyJob), _amount);
  }

  function removeLiquidityFromJob(address _escrow) external override onlyGovernorOrMechanic {
    require(_escrow == address(Escrow1) || _escrow == address(Escrow2), 'Keep3rEscrowJob::removeLiquidityFromJob:invalid-escrow');
    IKeep3rEscrow Escrow = IKeep3rEscrow(_escrow);
    Escrow.removeLiquidityFromJob(address(Liquidity), address(Keep3rProxyJob));
  }

  // Escrow Governable and CollectableDust governor bypass
  function setPendingGovernorOnEscrow(address _escrow, address _pendingGovernor) external override onlyGovernor {
    require(_escrow == address(Escrow1) || _escrow == address(Escrow2), 'Keep3rEscrowJob::removeLiquidityFromJob:invalid-escrow');
    IKeep3rEscrow Escrow = IKeep3rEscrow(_escrow);
    Escrow.setPendingGovernor(_pendingGovernor);
  }

  function acceptGovernorOnEscrow(address _escrow) external override onlyGovernor {
    require(_escrow == address(Escrow1) || _escrow == address(Escrow2), 'Keep3rEscrowJob::removeLiquidityFromJob:invalid-escrow');
    IKeep3rEscrow Escrow = IKeep3rEscrow(_escrow);
    Escrow.acceptGovernor();
  }

  function sendDustOnEscrow(
    address _escrow,
    address _to,
    address _token,
    uint256 _amount
  ) external override onlyGovernor {
    require(_escrow == address(Escrow1) || _escrow == address(Escrow2), 'Keep3rEscrowJob::removeLiquidityFromJob:invalid-escrow');
    IKeep3rEscrow Escrow = IKeep3rEscrow(_escrow);
    Escrow.sendDust(_to, _token, _amount);
  }
}
