// SPDX-FileCopyrightText: 2021 Tenderize <info@tenderize.me>

// SPDX-License-Identifier: MIT

pragma solidity 0.8.4;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "../../../libs/MathUtils.sol";

import "../../Tenderizer.sol";
import "../../WithdrawalPools.sol";
import "./IAudius.sol";

import { ITenderSwapFactory } from "../../../tenderswap/TenderSwapFactory.sol";

contract Audius is Tenderizer {
    using WithdrawalPools for WithdrawalPools.Pool;

    // Eventws for WithdrawalPool
    event ProcessUnstakes(address indexed from, address indexed node, uint256 amount);
    event ProcessWithdraws(address indexed from, uint256 amount);

    IAudius audius;

    address audiusStaking;

    WithdrawalPools.Pool withdrawPool;

    function initialize(
        IERC20 _steak,
        string calldata _symbol,
        IAudius _audius,
        address _node,
        uint256 _protocolFee,
        uint256 _liquidityFee,
        ITenderToken _tenderTokenTarget,
        TenderFarmFactory _tenderFarmFactory,
        ITenderSwapFactory _tenderSwapFactory
    ) public {
        Tenderizer._initialize(
            _steak,
            _symbol,
            _node,
            _protocolFee,
            _liquidityFee,
            _tenderTokenTarget,
            _tenderFarmFactory,
            _tenderSwapFactory
        );
        audius = _audius;
        audiusStaking = audius.getStakingAddress();
    }

    

    

    

    function processUnstake(address _node) external onlyGov {
        uint256 amount = withdrawPool.processUnlocks();

        // if no _node is specified, use default
        address node_ = _node;
        if (node_ == address(0)) {
            node_ = node;
        }
        
        // Undelegate from audius
        audius.requestUndelegateStake(node_, amount);

        emit ProcessUnstakes(msg.sender, node_, amount);
    }

    

    function processWithdraw(address /* _node */) external onlyGov {
        uint256 balBefore = steak.balanceOf(address(this));
        
        audius.undelegateStake();
        
        uint256 balAfter = steak.balanceOf(address(this));
        uint256 amount = balAfter - balBefore;
        
        withdrawPool.processWihdrawal(amount);

        emit ProcessWithdraws(msg.sender, amount);
    }

    


    

    
}
