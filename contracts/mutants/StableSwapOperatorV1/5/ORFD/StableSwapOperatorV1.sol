// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.4;

import "../PCVDeposit.sol";
import "../../Constants.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

// Curve metapool
interface IStableSwap2 {
    function coins(uint256 arg0) external view returns (address);
    function balances(uint256 arg0) external view returns (uint256);
    function add_liquidity(uint256[2] memory amounts, uint256 min_mint_amount) external;
    function remove_liquidity(uint256 _amount, uint256[2] memory min_amounts) external;
    function remove_liquidity_one_coin(uint256 _token_amount, int128 i, uint256 min_amount) external;
    function get_virtual_price() external view returns (uint256);
    function calc_withdraw_one_coin(uint256 _token_amount, int128 i) external view returns (uint256);
}
interface IStableSwap3 {
    function coins(uint256 arg0) external view returns (address);
    function balances(uint256 arg0) external view returns (uint256);
    function add_liquidity(uint256[3] memory amounts, uint256 min_mint_amount) external;
    function remove_liquidity(uint256 _amount, uint256[3] memory min_amounts) external;
    function remove_liquidity_one_coin(uint256 _token_amount, int128 i, uint256 min_amount) external;
    function get_virtual_price() external view returns (uint256);
    function calc_withdraw_one_coin(uint256 _token_amount, int128 i) external view returns (uint256);
}

/// @title StableSwapOperator: implementation for a Curve Metapool market-maker.
/// This is version 1, it only allows simple deposits and does not require the
/// Minter role. FEI has to be minted on this contract before calling deposit().
/// There are no reweight mechanisms.
/// All accounting and withdrawals are denominated in DAI. Should the contract
/// hold USDC or USDT, these can also be deposited.
/// @author eswak
contract StableSwapOperatorV1 is PCVDeposit {
    using SafeERC20 for ERC20;

    // ------------------ Properties -------------------------------------------

    uint256 public depositMaxSlippageBasisPoints;

    /// @notice The StableSwap pool to deposit in
    address public pool;

    /// @notice the min and max ratios for FEI-to-value in pool (these can be set by governance)
    /// @notice this ratio is expressed as a percentile with 18 decimal precision, ie 0.1e18 = 10%
    uint256 public minimumRatioThreshold;
    uint256 public maximumRatioThreshold;

    // ------------------ Private properties -----------------------------------

    /// some fixed variables to interact with the pool
    uint8 private immutable _feiIndex; // index of FEI in the pool (0 or 1)
    uint8 private immutable _3crvIndex; // index of 3crv in the pool (0 or 1)
    address private immutable _3crv; // address of the 3crv token
    address private immutable _3pool; // address of the 3pool
    address private immutable _dai; // address of the DAI token
    address private immutable _usdc; // address of the USDC token
    address private immutable _usdt; // address of the USDT token

    // ------------------ Constructor ------------------------------------------

    /// @notice Curve PCV Deposit constructor
    /// @param _core Fei Core for reference
    /// @param _pool StableSwap to deposit to
    /// @param _curve3pool the Curve 3pool
    /// @param _depositMaxSlippageBasisPoints max slippage for deposits, in bp
    constructor(
        address _core,
        address _pool,
        address _curve3pool,
        uint256 _depositMaxSlippageBasisPoints,
        uint256 _minimumRatioThreshold,
        uint256 _maximumRatioThreshold
    ) CoreRef(_core) {
        _setMinRatioThreshold(_minimumRatioThreshold);
        _setMaxRatioThreshold(_maximumRatioThreshold);

        // public variables
        pool = _pool;
        depositMaxSlippageBasisPoints = _depositMaxSlippageBasisPoints;

        // cached private variables
        uint8 _3crvIndexTmp = IStableSwap2(pool).coins(0) == address(fei()) ? 1 : 0;
        _3crvIndex = _3crvIndexTmp;
        _feiIndex = _3crvIndexTmp == 0 ? 1 : 0;
        _3crv = IStableSwap2(pool).coins(_3crvIndexTmp);
        _3pool = _curve3pool;
        _dai = IStableSwap3(_curve3pool).coins(0);
        _usdc = IStableSwap3(_curve3pool).coins(1);
        _usdt = IStableSwap3(_curve3pool).coins(2);
    }


    /// @notice set the minimum ratio threshold for a valid reading of restistant balances
    function setMinRatio(uint256 _minimumRatioThreshold) public onlyGovernor {
        _setMinRatioThreshold(_minimumRatioThreshold);
    }

    /// @notice set the maximum ratio threshold for a valid reading of resistant balances
    function setMaxRatio(uint256 _maximumRatioThreshold) public onlyGovernor {
        _setMaxRatioThreshold(_maximumRatioThreshold);
    }

    /// @notice set both min & max ratios
    function setRatios(uint256 _minimumRatioThreshold, uint256 _maximumRatioThreshold) public onlyGovernor {
        _setMinRatioThreshold(_minimumRatioThreshold);
        _setMaxRatioThreshold(_maximumRatioThreshold);
    }

    function _setMinRatioThreshold(uint256 _minimumRatioThreshold) internal {
        require(_minimumRatioThreshold >= 0.0001e18, "Min ratio must be at least 0.01%.");
        minimumRatioThreshold = _minimumRatioThreshold;
    }

    function _setMaxRatioThreshold(uint256 _maximumRatioThreshold) internal {
        require(_maximumRatioThreshold <= 10_000e18, "Max ratio cannot be above 10,000x.");
        maximumRatioThreshold = _maximumRatioThreshold;
    }

    /// @notice deposit DAI, USDC, USDT, 3crv, and FEI into the pool.
    /// Note: the FEI has to be minted & deposited on this contract in a previous
    ///       tx, as this contract does not use the Minter role.
    

    /// @notice withdraw DAI from the deposit. This will remove liquidity in the
    /// current pool's proportion, burn the FEI part of it, and then use the 3crv
    /// to withdraw liquidity of the 3pool in DAI.
    /// note: because of slippage & fees on withdraw, the amount of DAI out is
    ///        not exactly the expected amountUnderlying provided as input.
    /// @param amountUnderlying of tokens withdrawn
    /// @param to the address to send PCV to (self = no transfer)
    

    /// @notice returns the DAI balance of PCV in the Deposit, if it were to
    /// perform the following steps :
    /// - remove liquidity with all its LP tokens.
    /// - burn the FEI, keep only the 3crv.
    /// - Redeem the 3crv part of its LP + eventual 3crv held on the contract
    ///   to DAI on the 3pool.
    /// Note: there is a rounding error compared to what would happend with an
    /// actual call to remove_liquidity_one_coin().
    

    /// @notice returns the token address in which this contract reports its
    /// balance.
    /// @return the DAI address
    

    /// @notice gets the resistant token balance and protocol owned fei of this deposit
    /// for balance, returns half of the theoretical USD value of the LP tokens, even though
    /// there may be some slippage when withdrawing to DAI only. for fei, take the
    /// same value (assumes there is no broken peg in the pool).
    /// @return resistantBalance the resistant balance of DAI (theoretical USD value)
    /// @return resistantFei the resistant balance of FEI (theoretical USD value)
    
}
