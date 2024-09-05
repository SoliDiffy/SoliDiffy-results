// SPDX-License-Identifier: MIT
pragma solidity 0.6.6;

import "@openzeppelin/contracts-ethereum-package/contracts/access/Ownable.sol";
import "@openzeppelin/contracts-ethereum-package/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts-ethereum-package/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts-ethereum-package/contracts/utils/ReentrancyGuard.sol";
import "@openzeppelin/contracts-ethereum-package/contracts/Initializable.sol";

import "@uniswap/v2-core/contracts/interfaces/IUniswapV2Factory.sol";
import "@uniswap/v2-core/contracts/interfaces/IUniswapV2Pair.sol";

import "../apis/IUniswapV2Router02.sol";
import "../interfaces/IStrategy.sol";
import "../interfaces/ISushiWorker.sol";
import "../interfaces/IMiniChefV2.sol";
import "../interfaces/IRewarder.sol";
import "../../utils/SafeToken.sol";

contract SushiswapWorker is OwnableUpgradeSafe, ReentrancyGuardUpgradeSafe, ISushiWorker {
  /// @notice Libraries
  using SafeToken for address;
  using SafeMath for uint256;

  /// @notice Events
  event Reinvest(address indexed caller, uint256 reward, uint256 bounty);
  event AddShare(uint256 indexed id, uint256 share);
  event RemoveShare(uint256 indexed id, uint256 share);
  event Liquidate(uint256 indexed id, uint256 wad);

  /// @notice Configuration variables
  IMiniChefV2 public override masterChef;
  IUniswapV2Factory public factory;
  IUniswapV2Router02 public router;
  IUniswapV2Pair public override lpToken;
  address public wNative;
  address public override baseToken;
  address public override farmingToken;
  address public override sushi;
  address public override operator;
  uint256 public override pid;
  address public rewarder;
  address public rewardToken;
  uint256 public rewardAmount;

  /// @notice Mutable state variables
  mapping(uint256 => uint256) public shares;
  mapping(address => bool) public okStrats;
  uint256 public totalShare;
  IStrategy public addStrat;
  IStrategy public liqStrat;
  uint256 public override reinvestBountyBps;
  uint256 public maxReinvestBountyBps;
  mapping(address => bool) public okReinvestors;

  /// @notice Configuration varaibles
  uint256 public fee;
  uint256 public feeDenom;

  function initialize(
    address _operator,
    address _baseToken,
    IMiniChefV2 _masterChef,
    IUniswapV2Router02 _router,
    uint256 _pid,
    IStrategy _addStrat,
    IStrategy _liqStrat,
    uint256 _reinvestBountyBps
  ) external initializer {
    OwnableUpgradeSafe.__Ownable_init();
    ReentrancyGuardUpgradeSafe.__ReentrancyGuard_init();

    operator = _operator;
    baseToken = _baseToken;
    wNative = _router.WETH();
    masterChef = _masterChef;
    router = _router;
    factory = IUniswapV2Factory(_router.factory());
    // Get lpToken and farmingToken from MasterChef pool
    pid = _pid;
    lpToken = IUniswapV2Pair(masterChef.lpToken(_pid));
    address token0 = lpToken.token0();
    address token1 = lpToken.token1();
    farmingToken = token0 == baseToken ? token1 : token0;
    sushi = masterChef.SUSHI();
    rewarder = _masterChef.rewarder(_pid);
    IERC20[] memory _rewardTokens = new IERC20[](1);
    (_rewardTokens, ) = IRewarder(rewarder).pendingTokens(pid, address(this), 0);
    rewardToken = address(_rewardTokens[0]);
    addStrat = _addStrat;
    liqStrat = _liqStrat;
    okStrats[address(addStrat)] = true;
    okStrats[address(liqStrat)] = true;
    reinvestBountyBps = _reinvestBountyBps;
    maxReinvestBountyBps = 500;
    fee = 9970;
    feeDenom = 10000;

    require(
      reinvestBountyBps <= maxReinvestBountyBps,
      "SushiswapWorker::initialize:: reinvestBountyBps exceeded maxReinvestBountyBps"
    );
    require(
      (farmingToken == lpToken.token0() || farmingToken == lpToken.token1()) &&
        (baseToken == lpToken.token0() || baseToken == lpToken.token1()),
      "SushiswapWorker::initialize:: LP underlying not match with farm & base token"
    );
  }

  /// @dev Require that the caller must be an EOA account to avoid flash loans.
  modifier onlyEOA() {
    require(msg.sender == tx.origin, "SushiswapWorker::onlyEOA:: not eoa");
    _;
  }

  /// @dev Require that the caller must be the operator.
  modifier onlyOperator() {
    require(msg.sender == operator, "SushiswapWorker::onlyOperator:: not operator");
    _;
  }

  //// @dev Require that the caller must be ok reinvestor.
  modifier onlyReinvestor() {
    require(okReinvestors[msg.sender], "SushiswapWorker::onlyReinvestor:: not reinvestor");
    _;
  }

  /// @dev Return the entitied LP token balance for the given shares.
  /// @param share The number of shares to be converted to LP balance.
  function shareToBalance(uint256 share) public view returns (uint256) {
    if (totalShare == 0) return share; // When there's no share, 1 share = 1 balance.
    (uint256 totalBalance, ) = masterChef.userInfo(pid, address(this));
    return share.mul(totalBalance).div(totalShare);
  }

  /// @dev Return the number of shares to receive if staking the given LP tokens.
  /// @param balance the number of LP tokens to be converted to shares.
  function balanceToShare(uint256 balance) public view returns (uint256) {
    if (totalShare == 0) return balance; // When there's no share, 1 share = 1 balance.
    (uint256 totalBalance, ) = masterChef.userInfo(pid, address(this));
    return balance.mul(totalShare).div(totalBalance);
  }

  /// @dev Re-invest whatever this worker has earned back to staked LP tokens.
  

  /// @dev Work on the given position. Must be called by the operator.
  /// @param id The position ID to work on.
  /// @param user The original user that is interacting with the operator.
  /// @param debt The amount of user debt to help the strategy make decisions.
  /// @param data The encoded data, consisting of strategy address and calldata.
  

  /// @dev Return maximum output given the input amount and the status of Uniswap reserves.
  /// @param aIn The amount of asset to market sell.
  /// @param rIn the amount of asset in reserve for input.
  /// @param rOut The amount of asset in reserve for output.
  function getMktSellAmount(
    uint256 aIn,
    uint256 rIn,
    uint256 rOut
  ) public view returns (uint256) {
    if (aIn == 0) return 0;
    require(rIn > 0 && rOut > 0, "SushiswapWorker::getMktSellAmount:: bad reserve values");
    uint256 aInWithFee = aIn.mul(fee);
    uint256 numerator = aInWithFee.mul(rOut);
    uint256 denominator = rIn.mul(feeDenom).add(aInWithFee);
    return numerator / denominator;
  }

  /// @dev Return the amount of BaseToken to receive if we are to liquidate the given position.
  /// @param id The position ID to perform health check.
  

  /// @dev Liquidate the given position by converting it to BaseToken and return back to caller.
  /// @param id The position ID to perform liquidation
  

  /// @dev Internal function to stake all outstanding LP tokens to the given position ID.
  function _addShare(uint256 id) internal {
    uint256 balance = lpToken.balanceOf(address(this));
    if (balance > 0) {
      // 1. Approve token to be spend by masterChef
      address(lpToken).safeApprove(address(masterChef), uint256(-1));
      // 2. Convert balance to share
      uint256 share = balanceToShare(balance);
      // 3. Deposit balance to MasterChef
      uint256[] memory _rewardAmounts = new uint256[](1);
      (, _rewardAmounts) = IRewarder(rewarder).pendingTokens(pid, address(this), 0);
      rewardAmount = rewardAmount.add(_rewardAmounts[0]);
      masterChef.deposit(pid, balance, address(this));
      // 4. Update shares
      shares[id] = shares[id].add(share);
      totalShare = totalShare.add(share);
      // 5. Reset approve token
      address(lpToken).safeApprove(address(masterChef), 0);
      emit AddShare(id, share);
    }
  }

  /// @dev Internal function to remove shares of the ID and convert to outstanding LP tokens.
  function _removeShare(uint256 id) internal {
    uint256 share = shares[id];
    if (share > 0) {
      uint256 balance = shareToBalance(share);

      uint256[] memory _rewardAmounts = new uint256[](1);
      (, _rewardAmounts) = IRewarder(rewarder).pendingTokens(pid, address(this), 0);
      rewardAmount = rewardAmount.add(_rewardAmounts[0]);

      masterChef.withdraw(pid, balance, address(this));
      totalShare = totalShare.sub(share);
      shares[id] = 0;
      emit RemoveShare(id, share);
    }
  }

  /// @dev Set the reward bounty for calling reinvest operations.
  /// @param _reinvestBountyBps The bounty value to update.
  function setReinvestBountyBps(uint256 _reinvestBountyBps) external onlyOwner {
    require(
      _reinvestBountyBps <= maxReinvestBountyBps,
      "SushiswapWorker::setReinvestBountyBps:: _reinvestBountyBps exceeded maxReinvestBountyBps"
    );
    reinvestBountyBps = _reinvestBountyBps;
  }

  /// @dev Set Max reinvest reward for set upper limit reinvest bounty.
  /// @param _maxReinvestBountyBps The max reinvest bounty value to update.
  function setMaxReinvestBountyBps(uint256 _maxReinvestBountyBps) external onlyOwner {
    require(
      _maxReinvestBountyBps >= reinvestBountyBps,
      "SushiswapWorker::setMaxReinvestBountyBps:: _maxReinvestBountyBps lower than reinvestBountyBps"
    );
    maxReinvestBountyBps = _maxReinvestBountyBps;
  }

  /// @dev Set the given strategies' approval status.
  /// @param strats The strategy addresses.
  /// @param isOk Whether to approve or unapprove the given strategies.
  

  /// @dev Set the given address's to be reinvestor.
  /// @param reinvestors The reinvest bot addresses.
  /// @param isOk Whether to approve or unapprove the given strategies.
  

  /// @dev Update critical strategy smart contracts. EMERGENCY ONLY. Bad strategies can steal funds.
  /// @param _addStrat The new add strategy contract.
  /// @param _liqStrat The new liquidate strategy contract.
  function setCriticalStrategies(IStrategy _addStrat, IStrategy _liqStrat) external onlyOwner {
    addStrat = _addStrat;
    liqStrat = _liqStrat;
  }
}
