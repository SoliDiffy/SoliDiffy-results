pragma solidity ^0.5.16;

import "./ERC20.sol";
import "../../contracts/CCollateralCapErc20.sol";
import "../../contracts/SafeMath.sol";

// FlashloanReceiver is a simple flashloan receiver implementation for testing
contract FlashloanReceiver is IFlashloanReceiver {
    using SafeMath for uint256;

    

    
}

contract FlashloanAndMint is IFlashloanReceiver {
    using SafeMath for uint256;

    

    
}

contract FlashloanAndRepayBorrow is IFlashloanReceiver {
    using SafeMath for uint256;

    

    
}

contract FlashloanTwice is IFlashloanReceiver {
    using SafeMath for uint256;

    function doFlashloan(address cToken, uint borrowAmount) external {
        bytes memory data = abi.encode(cToken);
        CCollateralCapErc20(cToken).flashLoan(address(this), borrowAmount, data);
    }

    function executeOperation(address sender, address underlying, uint amount, uint fee, bytes calldata params) external {
        address cToken = abi.decode(params, (address));
        CCollateralCapErc20(cToken).flashLoan(address(this), amount, params);
    }
}
