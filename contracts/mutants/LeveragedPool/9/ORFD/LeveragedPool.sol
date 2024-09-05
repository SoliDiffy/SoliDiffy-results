//SPDX-License-Identifier: CC-BY-NC-ND-4.0
pragma solidity 0.8.7;

import "../interfaces/ILeveragedPool.sol";
import "../interfaces/IPoolCommitter.sol";
import "../interfaces/IPoolToken.sol";
import "@openzeppelin/contracts/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

import "./PoolSwapLibrary.sol";
import "../interfaces/IOracleWrapper.sol";

/// @title The pool contract itself
contract LeveragedPool is ILeveragedPool, Initializable {
    using SafeERC20 for IERC20;
    // #### Globals

    // Each balance is the amount of quote tokens in the pair
    uint256 public override shortBalance;
    uint256 public override longBalance;
    uint32 public override frontRunningInterval;
    uint32 public override updateInterval;
    bytes16 public fee;
    bytes16 public override leverageAmount;
    uint256 public constant LONG_INDEX = 0;
    uint256 public constant SHORT_INDEX = 1;

    address public governance;
    bool public paused;
    address public keeper;
    bool public governanceTransferInProgress;
    address public feeAddress;
    address public secondaryFeeAddress;
    address public override quoteToken;
    address public override poolCommitter;
    address public override oracleWrapper;
    address public override settlementEthOracle;
    address public provisionalGovernance;

    address[2] public tokens;
    uint256 public override lastPriceTimestamp; // The last time the pool was upkept

    string public override poolName;

    event Paused();
    event Unpaused();

    // #### Functions

    

    /**
     * @notice Execute a price change
     * @dev This is the entry point to upkeep a market
     */
    

    /**
     * @notice Pay keeper some amount in the collateral token for the perpetual pools market
     * @param to Address of the pool keeper to pay
     * @param amount Amount to pay the pool keeper
     * @return Whether the keeper is going to be paid; false if the amount exceeds the balances of the
     *         long and short pool, and true if the keeper can successfully be paid out
     */
    

    /**
     * @notice Transfer settlement tokens from pool to user
     * @param to Address of account to transfer to
     * @param amount Amount of quote tokens being transferred
     */
    

    /**
     * @notice Transfer long tokens from pool to user
     * @param to Address of account to transfer to
     * @param isLongToken True if transferring long pool token
     * @param amount Amount of quote tokens being transferred
     */
    

    /**
     * @notice Transfer tokens from user to account
     * @param from The account that's transferring quote tokens
     * @param to Address of account to transfer to
     * @param amount Amount of quote tokens being transferred
     */
    

    /**
     * @notice Execute the price change once the interval period ticks over, updating the long & short
     *         balances based on the change of the feed (upwards or downwards) and paying fees
     * @dev Can only be called by poolUpkeep; emits PriceChangeError if execution does not take place
     * @param _oldPrice Old price from the oracle
     * @param _newPrice New price from the oracle
     */
    function executePriceChange(int256 _oldPrice, int256 _newPrice) internal onlyUnpaused {
        // prevent a division by 0 in computing the price change
        // prevent negative pricing
        if (_oldPrice <= 0 || _newPrice <= 0) {
            emit PriceChangeError(_oldPrice, _newPrice);
        } else {
            uint256 _shortBalance = shortBalance;
            uint256 _longBalance = longBalance;
            PoolSwapLibrary.PriceChangeData memory priceChangeData = PoolSwapLibrary.PriceChangeData(
                _oldPrice,
                _newPrice,
                _longBalance,
                _shortBalance,
                leverageAmount,
                fee
            );
            (uint256 newLongBalance, uint256 newShortBalance, uint256 totalFeeAmount) = PoolSwapLibrary
                .calculatePriceChange(priceChangeData);

            unchecked {
                emit PoolRebalance(
                    int256(newShortBalance) - int256(_shortBalance),
                    int256(newLongBalance) - int256(_longBalance)
                );
            }
            // Update pool balances
            longBalance = newLongBalance;
            shortBalance = newShortBalance;
            // Pay the fee
            feeTransfer(totalFeeAmount);
        }
    }

    /**
     * @notice Execute the fee transfer transactions. Transfers fees to primary fee address (DAO) and secondary (pool deployer).
     *         If the DAO is the fee deployer, secondary fee address should be address(0) and all fees go to DAO.
     * @param totalFeeAmount total amount of fees paid
     */
    function feeTransfer(uint256 totalFeeAmount) internal {
        if (secondaryFeeAddress == address(0)) {
            IERC20(quoteToken).safeTransfer(feeAddress, totalFeeAmount);
        } else {
            uint256 daoFee = PoolSwapLibrary.mulFraction(totalFeeAmount, 9, 10);
            uint256 remainder = totalFeeAmount - daoFee;
            IERC20(quoteToken).safeTransfer(feeAddress, daoFee);
            IERC20(quoteToken).safeTransfer(secondaryFeeAddress, remainder);
        }
    }

    /**
     * @notice Sets the long and short balances of the pools
     * @dev Can only be called by & used by the pool committer
     * @param _longBalance New balance of the long pool
     * @param _shortBalance New balancee of the short pool
     */
    

    /**
     * @notice Mint tokens to a user
     * @dev Can only be called by & used by the pool committer
     * @param isLongToken True if minting short token
     * @param amount Amount of tokens to mint
     * @param minter Address of user/minter
     */
    

    /**
     * @notice Burn tokens by a user
     * @dev Can only be called by & used by the pool committer
     * @param isLongToken True if burning short token
     * @param amount Amount of tokens to burn
     * @param burner Address of user/burner
     */
    

    /**
     * @return true if the price was last updated more than updateInterval seconds ago
     */
    function intervalPassed() public view override returns (bool) {
        unchecked {
            return block.timestamp >= lastPriceTimestamp + updateInterval;
        }
    }

    /**
     * @notice Updates the fee address of the pool
     * @param account New address of the fee address/receiver
     */
    function updateFeeAddress(address account) external override onlyGov onlyUnpaused {
        require(account != address(0), "Account cannot be 0 address");
        address oldFeeAddress = feeAddress;
        feeAddress = account;
        emit FeeAddressUpdated(oldFeeAddress, feeAddress);
    }

    /**
     * @notice Updates the secondary fee address of the pool
     * @param account New address of the fee address/receiver
     */
    function updateSecondaryFeeAddress(address account) external override onlyUnpaused {
        address _oldSecondaryFeeAddress = secondaryFeeAddress;
        require(msg.sender == _oldSecondaryFeeAddress);
        secondaryFeeAddress = account;
        emit SecondaryFeeAddressUpdated(_oldSecondaryFeeAddress, account);
    }

    /**
     * @notice Updates the keeper contract of the pool
     * @param _keeper New address of the keeper contract
     */
    function setKeeper(address _keeper) external override onlyGov onlyUnpaused {
        require(_keeper != address(0), "Keeper address cannot be 0 address");
        address oldKeeper = keeper;
        keeper = _keeper;
        emit KeeperAddressChanged(oldKeeper, keeper);
    }

    /**
     * @notice Starts to transfer governance of the pool. The new governance
     *          address must call `claimGovernance` in order for this to take
     *          effect. Until this occurs, the existing governance address
     *          remains in control of the pool.
     * @param _governance New address of the governance of the pool
     * @dev First step of the two-step governance transfer process
     * @dev Sets the governance transfer flag to true
     * @dev See `claimGovernance`
     */
    function transferGovernance(address _governance) external override onlyGov onlyUnpaused {
        require(_governance != address(0), "Governance address cannot be 0 address");
        provisionalGovernance = _governance;
        governanceTransferInProgress = true;
        emit ProvisionalGovernanceChanged(_governance);
    }

    /**
     * @notice Completes transfer of governance by actually changing permissions
     *          over the pool.
     * @dev Second and final step of the two-step governance transfer process
     * @dev See `transferGovernance`
     * @dev Sets the governance transfer flag to false
     * @dev After a successful call to this function, the actual governance
     *      address and the provisional governance address MUST be equal.
     */
    function claimGovernance() external override onlyUnpaused {
        require(governanceTransferInProgress, "No governance change active");
        require(msg.sender == provisionalGovernance, "Not provisional governor");
        address oldGovernance = governance; /* for later event emission */
        governance = provisionalGovernance;
        governanceTransferInProgress = false;
        emit GovernanceAddressChanged(oldGovernance, governance);
    }

    /**
     * @return _latestPrice The oracle price
     * @return _data The oracleWrapper's metadata. Implementations can choose what data to return here
     * @return _lastPriceTimestamp The timestamp of the last upkeep
     * @return _updateInterval The update frequency for this pool
     * @dev To save gas so PoolKeeper does not have to make three external calls
     */
    function getUpkeepInformation()
        external
        view
        override
        returns (
            int256,
            bytes memory,
            uint256,
            uint256
        )
    {
        (int256 _latestPrice, bytes memory _data) = IOracleWrapper(oracleWrapper).getPriceAndMetadata();
        return (_latestPrice, _data, lastPriceTimestamp, updateInterval);
    }

    /**
     * @return The price of the pool's feed oracle
     */
    function getOraclePrice() external view override returns (int256) {
        return IOracleWrapper(oracleWrapper).getPrice();
    }

    function poolTokens() external view override returns (address[2] memory) {
        return tokens;
    }

    function balances() external view override returns (uint256, uint256) {
        return (shortBalance, longBalance);
    }

    /**
     * @notice Withdraws all available quote asset from the pool
     * @dev Pool must not be paused
     * @dev ERC20 transfer
     */
    function withdrawQuote() external onlyGov {
        require(paused, "Pool is live");
        IERC20 quoteERC = IERC20(quoteToken);
        uint256 balance = quoteERC.balanceOf(address(this));
        IERC20(quoteToken).safeTransfer(msg.sender, balance);
    }

    /**
     * @notice Pauses the pool
     * @dev Prevents all state updates until unpaused
     */
    function pause() external onlyGov {
        paused = true;
        emit Paused();
    }

    /**
     * @notice Unpauses the pool
     * @dev Prevents all state updates until unpaused
     */
    function unpause() external onlyGov {
        paused = false;
        emit Unpaused();
    }

    // #### Modifiers
    modifier onlyUnpaused() {
        require(!paused, "Pool is paused");
        _;
    }

    modifier onlyKeeper() {
        require(msg.sender == keeper, "msg.sender not keeper");
        _;
    }

    modifier onlyPoolCommitter() {
        require(msg.sender == poolCommitter, "msg.sender not poolCommitter");
        _;
    }

    modifier onlyGov() {
        require(msg.sender == governance, "msg.sender not governance");
        _;
    }
}
