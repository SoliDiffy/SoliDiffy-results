// SPDX-License-Identifier: UNLICENSED
pragma solidity >= 0.7.0;

import "@openzeppelin/contracts-upgradeable/math/SafeMathUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/PausableUpgradeable.sol";
import "./interfaces/ISTokens.sol";
import "./interfaces/IUTokens.sol";
import "./interfaces/ILiquidStaking.sol";
import "./libraries/FullMath.sol";

contract LiquidStaking is ILiquidStaking, PausableUpgradeable, AccessControlUpgradeable {

    using SafeMathUpgradeable for uint256;
    using FullMath for uint256;

    //Private instances of contracts to handle Utokens and Stokens
    IUTokens private _uTokens;
    ISTokens private _sTokens;

    // defining the fees and minimum values
    uint256 private _minStake;
    uint256 private _minUnstake;
    uint256 private _stakeFee;
    uint256 private _unstakeFee;
    uint256 private _valueDivisor;

    // constants defining access control ROLES
    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");

    // variables pertaining to unbonding logic
    uint256 private _unstakingLockTime;
    uint256 private _epochInterval;
    uint256 private _unstakeEpoch;
    uint256 private _unstakeEpochPrevious;

    //Mapping to handle the Expiry period
    mapping(address => uint256[]) private _unstakingExpiration;

    //Mapping to handle the Expiry amount
    mapping(address => uint256[]) private _unstakingAmount;

    //mappint to handle a counter variable indicating from what index to start the loop.
    mapping(address => uint256) internal _withdrawCounters;

    /**
   * @dev Constructor for initializing the LiquidStaking contract.
   * @param uAddress - address of the UToken contract.
   * @param sAddress - address of the SToken contract.
   * @param pauserAddress - address of the pauser admin.
   * @param unstakingLockTime - varies from 21 hours to 21 days.
   * @param epochInterval - varies from 3 hours to 3 days.
   * @param valueDivisor - valueDivisor set to 10^9.
   */
    function initialize(address uAddress, address sAddress, address pauserAddress, uint256 unstakingLockTime, uint256 epochInterval, uint256 valueDivisor) public virtual initializer  {
        __AccessControl_init();
        __Pausable_init();
        _setupRole(DEFAULT_ADMIN_ROLE, _msgSender());
        _setupRole(PAUSER_ROLE, pauserAddress);
        setUTokensContract(uAddress);
        setSTokensContract(sAddress);
        setUnstakingLockTime(unstakingLockTime);
        setMinimumValues(1, 1);
        _valueDivisor = valueDivisor;
        setUnstakeEpoch(block.timestamp, block.timestamp, epochInterval);
    }

    /**
     * @dev Set 'fees', called from admin
     * @param stakeFee: stake fee
     * @param unstakeFee: unstake fee
     *
     * Emits a {SetFees} event with 'fee' set to the stake and unstake.
     *
     */
    function setFees(uint256 stakeFee, uint256 unstakeFee) public virtual returns (bool success) {
        require(hasRole(DEFAULT_ADMIN_ROLE, _msgSender()), "LQ1");
        // range checks for fees. Since fee cannot be more than 100%, the max cap 
        // is _valueDivisor * 100, which then brings the fees to 100 (percentage) 
        require((stakeFee <= _valueDivisor.mul(100) || stakeFee == 0) && (unstakeFee <= _valueDivisor.mul(100) || unstakeFee == 0), "LQ2");
        _stakeFee = stakeFee;
        _unstakeFee = unstakeFee;
        emit SetFees(stakeFee, unstakeFee);
        return true;
    }

    /**
     * @dev Set 'unstake props', called from admin
     * @param unstakingLockTime: varies from 21 hours to 21 days
     *
     * Emits a {SetUnstakeProps} event with 'fee' set to the stake and unstake.
     * 
     */
    function setUnstakingLockTime(uint256 unstakingLockTime) public virtual returns (bool success) {
        require(hasRole(DEFAULT_ADMIN_ROLE, _msgSender()), "LQ3");
        _unstakingLockTime = unstakingLockTime;
        emit SetUnstakingLockTime(unstakingLockTime);
        return true;
    }

    /**
     * @dev get fees, min values, value divisor and epoch props
     *
     */
    function getStakeUnstakeProps() public view virtual returns (
        uint256 stakeFee, uint256 unstakeFee, uint256 minStake, uint256 minUnstake, uint256 valueDivisor,
        uint256 epochInterval, uint256 unstakeEpoch, uint256 unstakeEpochPrevious, uint256 unstakingLockTime
    ) {
        stakeFee = _stakeFee;
        unstakeFee = _unstakeFee;
        minStake = _minStake;
        minUnstake = _minStake;
        valueDivisor = _valueDivisor;
        epochInterval= _epochInterval;
        unstakeEpoch = _unstakeEpoch;
        unstakeEpochPrevious = _unstakeEpochPrevious;
        unstakingLockTime = _unstakingLockTime;
    }

    /**
     * @dev Set 'minimum values', called from admin
     * @param minStake: stake minimum value
     * @param minUnstake: unstake minimum value
     *
     * Emits a {SetMinimumValues} event with 'minimum value' set to the stake and unstake.
     *
     */
    function setMinimumValues(uint256 minStake, uint256 minUnstake) public virtual returns (bool success){
        require(hasRole(DEFAULT_ADMIN_ROLE, _msgSender()), "LQ4");
        require(minStake >= 1, "LQ5");
        require(minUnstake >= 1, "LQ6");
        _minStake = minStake;
        _minUnstake = minUnstake;
        emit SetMinimumValues(minStake, minUnstake);
        return true;
    }

    /**
    * @dev Set 'unstake epoch', called from admin
    * @param unstakeEpoch: unstake epoch
    * @param unstakeEpochPrevious: unstake epoch previous(initially set to same value as unstakeEpoch)
    * @param epochInterval: varies from 3 hours to 3 days
    *
    * Emits a {SetUnstakeEpoch} event with 'unstakeEpoch'
    *
    */
    function setUnstakeEpoch(uint256 unstakeEpoch, uint256 unstakeEpochPrevious, uint256 epochInterval) public virtual returns (bool success){
        require(hasRole(DEFAULT_ADMIN_ROLE, _msgSender()), "LQ7");
        require(unstakeEpochPrevious <= unstakeEpoch, "LQ8");
        // require((unstakeEpoch == 0 && unstakeEpochPrevious == 0 && epochInterval == 0) || (unstakeEpoch != 0 && unstakeEpochPrevious != 0 && epochInterval != 0), "LQ9");
        if(unstakeEpoch == 0 && epochInterval != 0) revert("LQ9");
        _unstakeEpoch = unstakeEpoch;
        _unstakeEpochPrevious = unstakeEpochPrevious;
        _epochInterval = epochInterval;
        emit SetUnstakeEpoch(unstakeEpoch, unstakeEpochPrevious, epochInterval);
        return true;
    }

    /**
     * @dev Set 'contract address', called from constructor
     * @param uAddress: utoken contract address
     *
     * Emits a {SetUTokensContract} event with '_contract' set to the utoken contract address.
     *
     */
    

    /**
     * @dev Set 'contract address', called from constructor
     * @param sAddress: stoken contract address
     *
     * Emits a {SetSTokensContract} event with '_contract' set to the stoken contract address.
     *
     */
    

    /**
    * @dev Stake utokens over the platform with address 'to' for desired 'amount'(Burn uTokens and Mint sTokens)
    * @param to: user address for staking, amount: number of tokens to stake
    *
    *
    * Requirements:
    *
    * - `amount` cannot be less than zero.
    * - 'amount' cannot be more than balance
    * - 'amount' plus new balance should be equal to the old balance
    */
    

    /**
     * @dev UnStake stokens over the platform with address 'to' for desired 'amount' (Burn sTokens and Mint uTokens with 21 days locking period)
     * @param to: user address for staking, amount: number of tokens to unstake
     *
     *
     * Requirements:
     *
     * - `amount` cannot be less than zero.
     * - 'amount' cannot be more than balance
     * - 'amount' plus new balance should be equal to the old balance
     */
    

    /**
     * @dev returns the nearest epoch milestone in the future
     */
    

    /**
     * @dev returns the time left for unbonding to finish
     */
    

    /**
     * @dev Lock the unstaked tokens for 21 days, user can withdraw the same (Mint uTokens with 21 days locking period)
     *
     * @param staker: user address for withdraw
     *
     * Requirements:
     *
     * - `current block timestamp` should be after 21 days from the period where unstaked function is called.
     */
    

    /**
     * @dev get Total Unbonded Tokens
     * @param staker: account address
     *
     */
    

    /**
     * @dev get Total Unbonding Tokens
     * @param staker: account address
     *
     */
    function getTotalUnbondingTokens(address staker) public view virtual override returns (uint256 unbondingTokens) {
        uint256 _unstakingExpirationLength = _unstakingExpiration[staker].length;
        uint256 _counter = _withdrawCounters[staker];
        for (uint256 i=_counter; i<_unstakingExpirationLength; i=i.add(1)) {
            //get getUnstakeTime and compare it with current timestamp to check if 21 days + epoch difference has passed
            (uint256 _getUnstakeTime, , ) = getUnstakeTime(_unstakingExpiration[staker][i]);
            if (block.timestamp < _getUnstakeTime) {
                //if 21 days + epoch difference have not passed, then check the token amount and send back
                unbondingTokens = unbondingTokens.add(_unstakingAmount[staker][i]);
            }
        }
        return unbondingTokens;
    }

    /**
      * @dev Triggers stopped state.
      *
      * Requirements:
      *
      * - The contract must not be paused.
      */
    function pause() public virtual returns (bool success) {
        require(hasRole(PAUSER_ROLE, _msgSender()), "LQ22");
        _pause();
        return true;
    }

    /**
     * @dev Returns to normal state.
     *
     * Requirements:
     *
     * - The contract must be paused.
     */
    function unpause() public virtual returns (bool success) {
        require(hasRole(PAUSER_ROLE, _msgSender()), "LQ23");
        _unpause();
        return true;
    }
}