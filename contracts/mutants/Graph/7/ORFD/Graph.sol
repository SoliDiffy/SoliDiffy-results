// SPDX-FileCopyrightText: 2021 Tenderize <info@tenderize.me>

// SPDX-License-Identifier: MIT

pragma solidity 0.8.4;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "../../../libs/MathUtils.sol";

import "../../Tenderizer.sol";
import "../../WithdrawalPools.sol";
import "./IGraph.sol";

import { ITenderSwapFactory } from "../../../tenderswap/TenderSwapFactory.sol";

contract Graph is Tenderizer {
    using WithdrawalPools for WithdrawalPools.Pool;

    // Eventws for WithdrawalPool
    event ProcessUnstakes(address indexed from, address indexed node, uint256 amount);
    event ProcessWithdraws(address indexed from, uint256 amount);
    
    // 100% in parts per million
    uint32 private constant MAX_PPM = 1000000;

    IGraph graph;

    WithdrawalPools.Pool withdrawPool;

    function initialize(
        IERC20 _steak,
        string calldata _symbol,
        IGraph _graph,
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
        graph = _graph;
    }

    

    

    

    

    function processUnstake(address _node) external onlyGov {
        uint256 amount = withdrawPool.processUnlocks();

        // if no _node is specified, use default
        address node_ = _node;
        if (node_ == address(0)) {
            node_ = node;
        }

        // Calculate the amount of shares to undelegate
        IGraph.DelegationPool memory delPool = graph.delegationPools(node_);

        uint256 totalShares = delPool.shares;
        uint256 totalTokens = delPool.tokens;

        uint256 shares = (amount * totalShares) / totalTokens;

        // Shares =  amount * totalShares / totalTokens
        // undelegate shares
        graph.undelegate(node_, shares);

        emit ProcessUnstakes(msg.sender, node_, amount);
    }

    

    function processWithdraw(address _node) external onlyGov {
        // if no _node is specified, use default
        address node_ = _node;
        if (node_ == address(0)) {
            node_ = node;
        }

        uint256 balBefore = steak.balanceOf(address(this));
        
        graph.withdrawDelegated(node_, address(0));
        
        uint256 balAfter = steak.balanceOf(address(this));
        uint256 amount = balAfter - balBefore;
        
        withdrawPool.processWihdrawal(amount);

        emit ProcessWithdraws(msg.sender, amount);
    }

    

    

    function _setStakingContract(address _stakingContract) internal override {
        graph = IGraph(_stakingContract);
        emit GovernanceUpdate("STAKING_CONTRACT");
    }
}
