pragma solidity =0.6.12;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/SafeERC20.sol";
import "../interfaces/IStrongHolder.sol";

contract SHPMock is IStrongHolder {
    using SafeERC20 for IERC20;

    address public rewardToken;

    event Locked(address to, uint256 amount);

    constructor(address _aliumToken) public {
        rewardToken = _aliumToken;
    }

    
}
