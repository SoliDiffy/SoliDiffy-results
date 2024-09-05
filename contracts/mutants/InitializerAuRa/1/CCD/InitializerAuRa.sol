pragma solidity 0.5.10;

import "./interfaces/IBlockRewardAuRa.sol";
import "./interfaces/ICertifier.sol";
import "./interfaces/IRandomAuRa.sol";
import "./interfaces/IStakingAuRa.sol";
import "./interfaces/ITxPermission.sol";
import "./interfaces/IValidatorSetAuRa.sol";



/// @dev Used once on network startup and then destroyed.
/// Needed for initializing upgradeable contracts since
/// upgradeable contracts can't have constructors.
contract InitializerAuRa {
    /// @param _contracts An array of the contracts:
    ///   0 is ValidatorSetAuRa,
    ///   1 is BlockRewardAuRa,
    ///   2 is RandomAuRa,
    ///   3 is StakingAuRa,
    ///   4 is TxPermission,
    ///   5 is Certifier.
    /// @param _owner The contracts' owner.
    /// @param _miningAddresses The array of initial validators' mining addresses.
    /// @param _stakingAddresses The array of initial validators' staking addresses.
    /// @param _firstValidatorIsUnremovable The boolean flag defining whether the first validator in the
    /// `_miningAddresses/_stakingAddresses` array is non-removable.
    /// Should be `false` for production network.
    /// @param _delegatorMinStake The minimum allowed amount of delegator stake in Wei
    /// (see the `StakingAuRa` contract).
    /// @param _candidateMinStake The minimum allowed amount of candidate stake in Wei
    /// (see the `StakingAuRa` contract).
    /// @param _stakingEpochDuration The duration of a staking epoch in blocks
    /// (e.g., 120954 = 1 week for 5-seconds blocks in AuRa).
    /// @param _stakingEpochStartBlock The number of the first block of initial staking epoch
    /// (must be zero if the network is starting from genesis block).
    /// @param _stakeWithdrawDisallowPeriod The duration period (in blocks) at the end of a staking epoch
    /// during which participants cannot stake or withdraw their staking tokens
    /// (e.g., 4320 = 6 hours for 5-seconds blocks in AuRa).
    /// @param _collectRoundLength The length of a collection round in blocks (see the `RandomAuRa` contract).
    
}
