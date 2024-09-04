pragma solidity >=0.4.21 <0.6.0;
import "../utils/Ownable.sol";
import "../erc20/SafeERC20.sol";
import "../erc20/IERC20.sol";
import "../utils/SafeMath.sol";


contract TargetInterface{
  
}

contract ERC20DepositApprover{
  using SafeERC20 for IERC20;
  using SafeMath for uint256;

  function allowance(address token, address owner, address spender) public view returns(uint256){
    return IERC20(token).allowance(owner, spender);
  }

  event ApproverDeposit(address from, address token, uint256 amount, address target, address target_lp_token, uint256 target_lp_amount);
  

}
