// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.8.0;
pragma experimental ABIEncoderV2;

// ====================================================================
// |     ______                   _______                             |
// |    / _____________ __  __   / ____(_____  ____ _____  ________   |
// |   / /_  / ___/ __ `| |/_/  / /_  / / __ \/ __ `/ __ \/ ___/ _ \  |
// |  / __/ / /  / /_/ _>  <   / __/ / / / / / /_/ / / / / /__/  __/  |
// | /_/   /_/   \__,_/_/|_|  /_/   /_/_/ /_/\__,_/_/ /_/\___/\___/   |
// |                                                                  |
// ====================================================================
// ======================= FraxUnifiedFarm_ERC20 ======================
// ====================================================================
// For ERC20 Tokens
// Uses FraxUnifiedFarmTemplate.sol

import "./FraxUnifiedFarmTemplate.sol";

// -------------------- VARIES --------------------

// G-UNI
import "../Misc_AMOs/gelato/IGUniPool.sol";

// mStable
// import '../Misc_AMOs/mstable/IFeederPool.sol';

// // StakeDAO sdETH-FraxPut
// import '../Misc_AMOs/stakedao/IOpynPerpVault.sol';

// StakeDAO Vault
// import '../Misc_AMOs/stakedao/IStakeDaoVault.sol';

// Uniswap V2
// import '../Uniswap/Interfaces/IUniswapV2Pair.sol';

// ------------------------------------------------

contract FraxUnifiedFarm_ERC20 is FraxUnifiedFarmTemplate {

    /* ========== STATE VARIABLES ========== */

    // -------------------- VARIES --------------------

    // G-UNI
    IGUniPool public stakingToken;
    
    // mStable
    // IFeederPool public stakingToken;

    // sdETH-FraxPut Vault
    // IOpynPerpVault public stakingToken;

    // StakeDAO Vault
    // IStakeDaoVault public stakingToken;

    // Uniswap V2
    // IUniswapV2Pair public stakingToken;

    // ------------------------------------------------

    // Stake tracking
    mapping(address => LockedStake[]) public lockedStakes;

    /* ========== STRUCTS ========== */

    // Struct for the stake
    struct LockedStake {
        bytes32 kek_id;
        uint256 start_timestamp;
        uint256 liquidity;
        uint256 ending_timestamp;
        uint256 lock_multiplier; // 6 decimals of precision. 1x = 1000000
    }
    
    /* ========== CONSTRUCTOR ========== */

    constructor (
        address _owner,
        address _stakingToken,
        address[] memory _rewardTokens,
        address[] memory _rewardManagers,
        uint256[] memory _rewardRatesManual,
        address[] memory _gaugeControllers
    ) 
    FraxUnifiedFarmTemplate(_owner, _rewardTokens, _rewardManagers, _rewardRatesManual, _gaugeControllers)
    {

        // -------------------- VARIES --------------------
        // G-UNI
        stakingToken = IGUniPool(_stakingToken);
        address token0 = address(stakingToken.token0());
        frax_is_token0 = token0 == frax_address;

        // mStable
        // stakingToken = IFeederPool(_stakingToken);

        // StakeDAO sdETH-FraxPut Vault
        // stakingToken = IOpynPerpVault(_stakingToken);

        // StakeDAO Vault
        // stakingToken = IStakeDaoVault(_stakingToken);

        // Uniswap V2
        // stakingToken = IUniswapV2Pair(_stakingToken);
        // address token0 = stakingToken.token0();
        // if (token0 == frax_address) frax_is_token0 = true;
        // else frax_is_token0 = false;
        // ------------------------------------------------

    }

    /* ============= VIEWS ============= */

    // ------ FRAX RELATED ------

    

    // ------ LIQUIDITY AND WEIGHTS ------

    // Calculated the combined weight for an account
    

    // ------ LOCK RELATED ------

    // All the locked stakes for a given account
    function lockedStakesOf(address account) external view returns (LockedStake[] memory) {
        return lockedStakes[account];
    }

    // All the locked stakes for a given account [old-school method]
    function lockedStakesOfMultiArr(address account) external view returns (
        bytes32[] memory kek_ids,
        uint256[] memory start_timestamps,
        uint256[] memory liquidities,
        uint256[] memory ending_timestamps,
        uint256[] memory lock_multipliers
    ) {
        for (uint256 i = 0; i < lockedStakes[account].length; i++){ 
            LockedStake memory thisStake = lockedStakes[account][i];
            kek_ids[i] = thisStake.kek_id;
            start_timestamps[i] = thisStake.start_timestamp;
            liquidities[i] = thisStake.liquidity;
            ending_timestamps[i] = thisStake.ending_timestamp;
            lock_multipliers[i] = thisStake.lock_multiplier;
        }
    }

    // Returns the length of the locked stakes for a given account
    function lockedStakesOfLength(address account) external view returns (uint256) {
        return lockedStakes[account].length;
    }

    /* =============== MUTATIVE FUNCTIONS =============== */

    // ------ STAKING ------

    function _getStake(address staker_address, bytes32 kek_id) internal view returns (LockedStake memory locked_stake, uint256 arr_idx) {
        for (uint256 i = 0; i < lockedStakes[staker_address].length; i++){ 
            if (kek_id == lockedStakes[staker_address][i].kek_id){
                locked_stake = lockedStakes[staker_address][i];
                arr_idx = i;
                break;
            }
        }
        require(locked_stake.kek_id == kek_id, "Stake not found");
        
    }

    // Extends the lock of an existing stake
    function extendLockTime(bytes32 kek_id, uint256 new_ending_ts) updateRewardAndBalance(msg.sender, true) public {
        // Get the stake and its index
        (LockedStake memory thisStake, uint256 theArrayIndex) = _getStake(msg.sender, kek_id);

        // Check 
        require(new_ending_ts > block.timestamp, "Must be in the future");
        require(new_ending_ts > thisStake.ending_timestamp, "Cannot shorten lock time");

        // Calculate the new seconds
        uint256 new_secs = new_ending_ts - block.timestamp;

        // Checks
        require(new_secs >= lock_time_min, "Minimum stake time not met");
        require(new_secs <= lock_time_for_max_multiplier, "Trying to lock for too long");

        // Update the stake
        lockedStakes[msg.sender][theArrayIndex] = LockedStake(
            kek_id,
            block.timestamp,
            thisStake.liquidity,
            new_ending_ts,
            lockMultiplier(new_secs)
        );

        // Need to call to update the combined weights
        _updateRewardAndBalance(msg.sender, false);
    }

    // Add additional LPs to an existing locked stake
    function lockAdditional(bytes32 kek_id, uint256 addl_liq) updateRewardAndBalance(msg.sender, true) public {
        // Get the stake and its index
        (LockedStake memory thisStake, uint256 theArrayIndex) = _getStake(msg.sender, kek_id);

        // Calculate the new amount
        uint256 new_amt = thisStake.liquidity + addl_liq;

        // Checks
        require(addl_liq >= 0, "Must be nonzero");

        // Pull the tokens from the sender
        TransferHelper.safeTransferFrom(address(stakingToken), msg.sender, address(this), addl_liq);

        // Update the stake
        lockedStakes[msg.sender][theArrayIndex] = LockedStake(
            kek_id,
            thisStake.start_timestamp,
            new_amt,
            thisStake.ending_timestamp,
            thisStake.lock_multiplier
        );

        // Need to call to update the combined weights
        _updateRewardAndBalance(msg.sender, false);
    }

    // Two different stake functions are needed because of delegateCall and msg.sender issues (important for migration)
    function stakeLocked(uint256 liquidity, uint256 secs) nonReentrant external {
        _stakeLocked(msg.sender, msg.sender, liquidity, secs, block.timestamp);
    }

    function _stakeLockedInternalLogic(
        address source_address,
        uint256 liquidity
    ) internal virtual {
        revert("Need _stakeLockedInternalLogic logic");
    }

    // If this were not internal, and source_address had an infinite approve, this could be exploitable
    // (pull funds from source_address and stake for an arbitrary staker_address)
    function _stakeLocked(
        address staker_address,
        address source_address,
        uint256 liquidity,
        uint256 secs,
        uint256 start_timestamp
    ) internal updateRewardAndBalance(staker_address, true) {
        require(stakingPaused == false || valid_migrators[msg.sender] == true, "Staking paused or in migration");
        require(greylist[staker_address] == false, "Address has been greylisted");
        require(secs >= lock_time_min, "Minimum stake time not met");
        require(secs <= lock_time_for_max_multiplier,"Trying to lock for too long");

        // Pull in the required token(s)
        // Varies per farm
        TransferHelper.safeTransferFrom(address(stakingToken), source_address, address(this), liquidity);

        // Get the lock multiplier and kek_id
        uint256 lock_multiplier = lockMultiplier(secs);
        bytes32 kek_id = keccak256(abi.encodePacked(staker_address, start_timestamp, liquidity, _locked_liquidity[staker_address]));
        
        // Create the locked stake
        lockedStakes[staker_address].push(LockedStake(
            kek_id,
            start_timestamp,
            liquidity,
            start_timestamp + secs,
            lock_multiplier
        ));

        // Update liquidities
        _total_liquidity_locked = _total_liquidity_locked + liquidity;
        _locked_liquidity[staker_address] = _locked_liquidity[staker_address] + liquidity;

        // Need to call again to make sure everything is correct
        _updateRewardAndBalance(staker_address, false);

        emit StakeLocked(staker_address, liquidity, secs, kek_id, source_address);
    }

    // ------ WITHDRAWING ------

    // Two different withdrawLocked functions are needed because of delegateCall and msg.sender issues (important for migration)
    function withdrawLocked(bytes32 kek_id) nonReentrant external {
        require(withdrawalsPaused == false, "Withdrawals paused");
        _withdrawLocked(msg.sender, msg.sender, kek_id);
    }

    // No withdrawer == msg.sender check needed since this is only internally callable and the checks are done in the wrapper
    // functions like migrator_withdraw_locked() and withdrawLocked()
    function _withdrawLocked(
        address staker_address,
        address destination_address,
        bytes32 kek_id
    ) internal {
        // Collect rewards first and then update the balances
        _getReward(staker_address, destination_address);

        // Get the stake and its index
        (LockedStake memory thisStake, uint256 theArrayIndex) = _getStake(staker_address, kek_id);
        require(block.timestamp >= thisStake.ending_timestamp || stakesUnlocked == true || valid_migrators[msg.sender] == true, "Stake is still locked!");
        uint256 liquidity = thisStake.liquidity;

        if (liquidity > 0) {
            // Update liquidities
            _total_liquidity_locked = _total_liquidity_locked - liquidity;
            _locked_liquidity[staker_address] = _locked_liquidity[staker_address] - liquidity;

            // Remove the stake from the array
            delete lockedStakes[staker_address][theArrayIndex];

            // Give the tokens to the destination_address
            // Should throw if insufficient balance
            stakingToken.transfer(destination_address, liquidity);

            // Need to call again to make sure everything is correct
            _updateRewardAndBalance(staker_address, false);

            emit WithdrawLocked(staker_address, liquidity, kek_id, destination_address);
        }
    }


    

     /* ========== RESTRICTED FUNCTIONS - Curator / migrator callable ========== */

    // Migrator can stake for someone else (they won't be able to withdraw it back though, only staker_address can). 
    function migrator_stakeLocked_for(address staker_address, uint256 amount, uint256 secs, uint256 start_timestamp) external isMigrating {
        require(staker_allowed_migrators[staker_address][msg.sender] && valid_migrators[msg.sender], "Mig. invalid or unapproved");
        _stakeLocked(staker_address, msg.sender, amount, secs, start_timestamp);
    }

    // Used for migrations
    function migrator_withdraw_locked(address staker_address, bytes32 kek_id) external isMigrating {
        require(staker_allowed_migrators[staker_address][msg.sender] && valid_migrators[msg.sender], "Mig. invalid or unapproved");
        _withdrawLocked(staker_address, msg.sender, kek_id);
    }
    
    /* ========== RESTRICTED FUNCTIONS - Owner or timelock only ========== */

    // Inherited...

    /* ========== EVENTS ========== */

    event StakeLocked(address indexed user, uint256 amount, uint256 secs, bytes32 kek_id, address source_address);
    event WithdrawLocked(address indexed user, uint256 liquidity, bytes32 kek_id, address destination_address);
}
