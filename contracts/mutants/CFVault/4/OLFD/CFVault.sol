pragma solidity >=0.4.21 <0.6.0;

import "../utils/Ownable.sol";
import "../utils/SafeMath.sol";
import "../utils/Address.sol";
import "../utils/ReentrancyGuard.sol";
import "../utils/TransferableToken.sol";
import "../erc20/SafeERC20.sol";
import "../erc20/ERC20Impl.sol";
import "./IPool.sol";

contract CFControllerInterface{
  
  
  function get_current_pool() public view returns(ICurvePool);
}

contract TokenInterfaceERC20{
  function destroyTokens(address _owner, uint _amount) public returns(bool);
  function generateTokens(address _owner, uint _amount) public returns(bool);
}

contract CFVaultV2 is Ownable, ReentrancyGuard{
  using SafeERC20 for IERC20;
  using SafeMath for uint256;
  using Address for address;
  using TransferableToken for address;

  address public target_token;
  CFControllerInterface public controller;

  uint256 public ratio_base;
  uint256 public withdraw_fee_ratio;
  address payable public fee_pool;
  address public lp_token;
  uint256 public max_amount;
  uint256 public slip;

  //@param _target_token, means ETH if it's 0x0
  constructor(address _target_token, address _lp_token, address _controller) public {
    require(_controller != address(0x0), "invalid controller");
    target_token = _target_token;
    controller = CFControllerInterface(_controller);
    ratio_base = 10000;
    lp_token = _lp_token;
  }

  event ChangeMaxAmount(uint256 old, uint256 _new);
  function set_max_amount(uint _amount) public onlyOwner{
    uint256 old = max_amount;
    max_amount = _amount;
    emit ChangeMaxAmount(old, max_amount);
  }

  event CFFDeposit(address from, uint256 target_amount, uint256 cff_amount, uint256 virtual_price);
  event CFFDepositFee(address from, uint256 target_amount, uint256 fee_amount);

  event ChangeSlippage(uint256 old, uint256 _new);
  function set_slippage(uint256 _slip) public onlyOwner{
    //base: 10000
    uint256 old = slip;
    slip = _slip;
    emit ChangeSlippage(old, slip);
  }

  


  event CFFWithdraw(address from, uint256 target_amount, uint256 cff_amount, uint256 target_fee, uint256 virtual_price);
  //@_amount: CFLPToken amount
  // SWC-107-Reentrancy: L121 - L153
  

  event ChangeWithdrawFee(uint256 old, uint256 _new);
  function changeWithdrawFee(uint256 _fee) public onlyOwner{
    require(_fee < ratio_base, "invalid fee");
    uint256 old = withdraw_fee_ratio;
    withdraw_fee_ratio = _fee;
    emit ChangeWithdrawFee(old, withdraw_fee_ratio);
  }

  event ChangeController(address old, address _new);
  function changeController(address _ctrl) public onlyOwner{
    address old = address(controller);
    controller = CFControllerInterface(_ctrl);
    emit ChangeController(old, address(controller));
  }

  event ChangeFeePool(address old, address _new);
  function changeFeePool(address payable _fp) public onlyOwner{
    address old = fee_pool;
    fee_pool = _fp;
    emit ChangeFeePool(old, fee_pool);
  }

  function get_virtual_price() public view returns(uint256){
    ICurvePool cp = controller.get_current_pool();
    uint256 v1 = cp.get_lp_token_balance().safeMul(uint256(10)**ERC20Base(lp_token).decimals());
    uint256 v2 = IERC20(lp_token).totalSupply().safeMul(uint256(10) ** ERC20Base(cp.get_lp_token_addr()).decimals());
    if(v2 == 0){
      return 0;
    }
    return v1.safeMul(cp.get_virtual_price()).safeDiv(v2);
  }
  // helper function added for local test, not deployed on chain
  function get_asset() public view returns(uint256) {
      return controller.get_current_pool().get_lp_token_balance();
  }

  function() external payable{}
}

contract CFVaultV2Factory{
  event NewCFVault(address addr);

  function createCFVault(address _target_token, address _lp_token, address _controller) public returns(address){
    CFVaultV2 cf = new CFVaultV2(_target_token, _lp_token, _controller);
    cf.transferOwnership(msg.sender);
    emit NewCFVault(address(cf));
    return address(cf);
  }

}
