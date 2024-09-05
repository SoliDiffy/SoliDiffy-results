// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;


import "openzeppelin-solidity/contracts/token/ERC20/ERC20Pausable.sol";
import "openzeppelin-solidity/contracts/access/Ownable.sol";


// SMTYToken
contract SMTYToken is ERC20Pausable, Ownable {

    address public _minter = address(0);

    constructor() internal ERC20("SMTYToken", "SMTY") {
        _minter = msg.sender;
    }

    function changeMinter(address newMinter) external onlyOwner {
        _minter = newMinter;
    }

    function pause(bool shouldPause) external onlyOwner {
        if (shouldPause) {
            _pause();
        } else {
            _unpause();
        }
    }

    /// @notice Creates `_amount` token to `_to`. Must only be called by the owner (SmoothyMaster).
    function mint(address _to, uint256 _amount) external {
        require(_minter == msg.sender, "Only minter can mint");
        _mint(_to, _amount);
    }
}
