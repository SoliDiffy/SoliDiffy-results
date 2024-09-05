// SPDX-License-Identifier: MIT

pragma solidity =0.6.12;
pragma experimental ABIEncoderV2;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "../governance/InitializableOwner.sol";

interface IvDsg {
    function donate(uint256 dsgAmount) external;
    function redeem(uint256 vDsgAmount, bool all) external;
     function balanceOf(address account) external view returns (uint256 vDsgAmount);
}

contract vDsgReserve is InitializableOwner {

    event Donte(uint256 amount);

    IvDsg public vdsg;
    IERC20 public dsg;

    function initialize (
        address _vDsg,
        address _dsg
    ) external {
        super._initialize();

        vdsg = IvDsg(_vDsg);
        dsg = IERC20(_dsg);
    }

    function donateToVDsg(uint256 amount) external onlyOwner {
        dsg.approve(address(vdsg), uint(-1));
        vdsg.donate(amount);

        emit Donte(amount);
    }

    function donateAllToVDsg() external onlyOwner {
        uint256 amount = dsg.balanceOf(address(this));
        require(amount > 0, "Insufficient balance");

        donateToVDsg(amount);
    }

    function redeem(uint256 vDsgAmount, bool all) external onlyOwner {
        vdsg.redeem(vDsgAmount, all);
    }

    function dsgBalance() external view returns(uint256) {
        return dsg.balanceOf(address(this));
    }

    function vdsgBalance() public view returns(uint256) {
        return vdsg.balanceOf(address(this));
    }
}