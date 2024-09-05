// SPDX-License-Identifier: MIT
pragma solidity 0.6.11;
pragma experimental ABIEncoderV2;

// ====================================================================
// |     ______                   _______                             |
// |    / _____________ __  __   / ____(_____  ____ _____  ________   |
// |   / /_  / ___/ __ `| |/_/  / /_  / / __ \/ __ `/ __ \/ ___/ _ \  |
// |  / __/ / /  / /_/ _>  <   / __/ / / / / / /_/ / / / / /__/  __/  |
// | /_/   /_/   \__,_/_/|_|  /_/   /_/_/ /_/\__,_/_/ /_/\___/\___/   |
// |                                                                  |
// ====================================================================
// =========================== GovernanceAMO ==========================
// ====================================================================
// Frax Finance: https://github.com/FraxFinance

import "../Math/Math.sol";
import "../Math/SafeMath.sol";
import "../ERC20/ERC20.sol";
import '../Uniswap/TransferHelper.sol';
import "../ERC20/SafeERC20.sol";
import "../Frax/Frax.sol";
import "../Utils/ReentrancyGuard.sol";
import "../Utils/StringHelpers.sol";

// Inheritance
import "../Staking/Owned.sol";
import "../Staking/Pausable.sol";

contract GovernanceAMO is Owned, ReentrancyGuard, Pausable {
    using SafeMath for uint256;
    using SafeERC20 for ERC20;

    /* ========== STATE VARIABLES ========== */

    FRAXStablecoin public FRAX;
    ERC20 internal rewardsToken0;
    ERC20 internal rewardsToken1;
    ERC20 internal stakingToken;
    uint256 internal periodFinish;

    // Constant for various precisions
    uint256 public constant PRICE_PRECISION = 1e6;
    uint256 public constant MULTIPLIER_BASE = 1e6;

    address internal owner_address;
    address internal timelock_address; // Governance timelock address



    /* ========== MODIFIERS ========== */

    modifier onlyByOwnerOrGovernance() {
        require(msg.sender == owner_address || msg.sender == timelock_address, "You are not the owner or the governance timelock");
        _;
    }

    /* ========== CONSTRUCTOR ========== */

    constructor(
        address _owner,
        address _timelock_address
    ) public Owned(_owner){
        owner_address = _owner;
        timelock_address = _timelock_address;
    }

    /* ========== VIEWS ========== */

    /* ========== RESTRICTED FUNCTIONS ========== */

    /* ========== EVENTS ========== */
}
