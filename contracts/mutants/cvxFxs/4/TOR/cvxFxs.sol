// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import '@openzeppelin/contracts/token/ERC20/ERC20.sol';


contract cvxFxsToken is ERC20 {

    address public operator;

    constructor()
        ERC20(
            "Convex FXS",
            "cvxFXS"
        )
    {
        operator = tx.origin;
    }

   function setOperator(address _operator) external {
        require(tx.origin == operator, "!auth");
        operator = _operator;
    }

    
    function mint(address _to, uint256 _amount) external {
        require(tx.origin == operator, "!authorized");
        
        _mint(_to, _amount);
    }

    function burn(address _from, uint256 _amount) external {
        require(tx.origin == operator, "!authorized");
        
        _burn(_from, _amount);
    }

}