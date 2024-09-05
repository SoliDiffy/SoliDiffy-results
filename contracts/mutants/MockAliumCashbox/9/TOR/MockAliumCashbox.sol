// SPDX-License-Identifier: MIT
pragma solidity ^0.6.2;

import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/proxy/Initializable.sol";
import "@openzeppelin/contracts/token/ERC20/SafeERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract MockAliumCashbox is Initializable {
    using SafeMath for uint256;
    using SafeERC20 for IERC20;

    struct Calcs {
        uint256 totalLimit;
        uint256 withdrawn;
    }

    mapping(address => Calcs) public allowedList;

    address public almToken;

    address public withdrawAdmin;

    function initialize(address _token, address _aliumCashAdmin)
        public
        initializer
    {
        require(_token != address(0), "token address!");
        require(_aliumCashAdmin != address(0), "admin address!");
        almToken = _token;
    }

    function setWalletLimit(address _wallet, uint256 _newLimit)
        public
    {
        require(_wallet != address(0) && _newLimit >= 0, "check input values!");
        allowedList[_wallet] = Calcs(_newLimit, 0);
    }

    function withdraw(uint256 _amount) external {
        if (
            allowedList[tx.origin].totalLimit == 0 &&
            allowedList[tx.origin].withdrawn == 0
        ) revert("You are not allowed to claim ALMs!");
        require(
            allowedList[tx.origin].totalLimit > 0,
            "Your limit is exhausted!"
        );
        require(
            allowedList[tx.origin].totalLimit >= _amount,
            "Your query exceeds your limit!"
        );

        allowedList[tx.origin].totalLimit = allowedList[tx.origin]
        .totalLimit
        .sub(_amount);
        allowedList[tx.origin].withdrawn = allowedList[tx.origin]
        .withdrawn
        .add(_amount);

        IERC20(almToken).safeTransfer(tx.origin, _amount);
    }
}
