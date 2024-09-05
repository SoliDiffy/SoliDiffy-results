pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

import "../DelegateBase.sol";
import "../interfaces/IexecAccessorsABILegacy.sol";


contract IexecAccessorsABILegacyDelegate is IexecAccessorsABILegacy, DelegateBase
{
	function viewDealABILegacy_pt1(bytes32 _id)
	external view override returns
	( address
	, address
	, uint256
	, address
	, address
	, uint256
	, address
	, address
	, uint256
	)
	{
		IexecLibCore_v5.Deal memory deal = m_deals[_id];
		return (
			deal.workerpool.owner,
			deal.app.pointer,
			deal.workerpool.price,
			deal.app.owner,
			deal.dataset.pointer,
			deal.app.price,
			deal.dataset.owner,
			deal.workerpool.pointer,
			deal.dataset.price
		);
	}

	function viewDealABILegacy_pt2(bytes32 _id)
	external view override returns
	( uint256
	, bytes32
	, address
	, address
	, address
	, string memory
	)
	{
		IexecLibCore_v5.Deal memory deal = m_deals[_id];
		return (
			deal.trust,
			deal.tag,
			deal.callback,
			deal.requester,
			deal.beneficiary,
			deal.params
		);
	}

	function viewConfigABILegacy(bytes32 _id)
	external view override returns
	( uint256
	, uint256
	, uint256
	, uint256
	, uint256
	, uint256
	)
	{
		IexecLibCore_v5.Deal memory deal = m_deals[_id];
		return (
			deal.schedulerRewardRatio,
			deal.category,
			deal.startTime,
			deal.botFirst,
			deal.botSize,
			deal.workerStake
		);
	}

	function viewAccountABILegacy(address account)
	external view override returns (uint256, uint256)
	{
		return ( m_frozens[account], m_balances[account] );
	}

	function viewTaskABILegacy(bytes32 _taskid)
	external view override returns
	( IexecLibCore_v5.TaskStatusEnum
	, bytes32
	, uint256
	, uint256
	, uint256
	, uint256
	, uint256
	, bytes32
	, uint256
	, uint256
	, address[] memory
	, bytes     memory
	)
	{
		IexecLibCore_v5.Task memory task = m_tasks[_taskid];
		return (
			task.finalDeadline,
			task.revealCounter,
			task.dealid,
			task.idx,
			task.timeref,
			task.contributionDeadline,
			task.status,
			task.revealDeadline,
			task.consensusValue,
			task.winnerCounter,
			// SWC-128-DoS With Block Gas Limit: L114
			task.contributors,
			task.results
		);
	}

	function viewContributionABILegacy(bytes32 _taskid, address _worker)
	external view override returns
	( IexecLibCore_v5.ContributionStatusEnum
	, bytes32
	, bytes32
	, address
	)
	{
		IexecLibCore_v5.Contribution memory contribution = m_contributions[_taskid][_worker];
		return (
			contribution.resultHash,
			contribution.status,
			contribution.resultSeal,
			contribution.enclaveChallenge
		);
	}

	function viewCategoryABILegacy(uint256 _catid)
	external view override returns (string memory, string memory, uint256)
	{
		IexecLibCore_v5.Category memory category = m_categories[_catid];
		return ( category.name, category.description, category.workClockTimeRef );
	}
}
