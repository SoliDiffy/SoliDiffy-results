pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

import "@iexec/solidity/contracts/ERC1154/IERC1154.sol";
import "./IexecERC20Common.sol";
import "./SignatureVerifier.sol";
import "../DelegateBase.sol";
import "../interfaces/IexecPoco.sol";


contract IexecPocoDelegate is IexecPoco, DelegateBase, IexecERC20Common, SignatureVerifier
{
	using SafeMathExtended  for uint256;
	using IexecLibOrders_v5 for bytes32;
	using IexecLibOrders_v5 for IexecLibOrders_v5.AppOrder;
	using IexecLibOrders_v5 for IexecLibOrders_v5.DatasetOrder;
	using IexecLibOrders_v5 for IexecLibOrders_v5.WorkerpoolOrder;
	using IexecLibOrders_v5 for IexecLibOrders_v5.RequestOrder;

	/***************************************************************************
	 *                        Escrow methods: internal                         *
	 ***************************************************************************/
	function reward(address user, uint256 amount, bytes32 ref)
	internal /* returns (bool) */
	{
		_transfer(address(this), user, amount);
		emit Reward(user, amount, ref);
		/* return true; */
	}

	function seize(address user, uint256 amount, bytes32 ref)
	internal /* returns (bool) */
	{
		m_frozens[user] = m_frozens[user].sub(amount);
		emit Seize(user, amount, ref);
		/* return true; */
	}

	function lock(address user, uint256 amount)
	internal /* returns (bool) */
	{
		_transfer(user, address(this), amount);
		m_frozens[user] = m_frozens[user].add(amount);
		emit Lock(user, amount);
		/* return true; */
	}

	function unlock(address user, uint256 amount)
	internal /* returns (bool) */
	{
		_transfer(address(this), user, amount);
		m_frozens[user] = m_frozens[user].sub(amount);
		emit Unlock(user, amount);
		/* return true; */
	}

	/***************************************************************************
	 *                    Escrow overhead for contribution                     *
	 ***************************************************************************/
	function lockContribution(bytes32 _dealid, address _worker)
	internal
	{
		lock(_worker, m_deals[_dealid].workerStake);
	}

	function unlockContribution(bytes32 _dealid, address _worker)
	internal
	{
		unlock(_worker, m_deals[_dealid].workerStake);
	}

	function rewardForContribution(address _worker, uint256 _amount, bytes32 _taskid)
	internal
	{
		reward(_worker, _amount, _taskid);
	}

	function seizeContribution(bytes32 _dealid, address _worker, bytes32 _taskid)
	internal
	{
		seize(_worker, m_deals[_dealid].workerStake, _taskid);
	}

	function rewardForScheduling(bytes32 _dealid, uint256 _amount, bytes32 _taskid)
	internal
	{
		reward(m_deals[_dealid].workerpool.owner, _amount, _taskid);
	}

	function successWork(bytes32 _dealid, bytes32 _taskid)
	internal
	{
		IexecLibCore_v5.Deal storage deal = m_deals[_dealid];

		uint256 requesterstake = deal.app.price
		                         .add(deal.dataset.price)
		                         .add(deal.workerpool.price);
		uint256 poolstake = deal.workerpool.price
		                    .percentage(WORKERPOOL_STAKE_RATIO);

		// seize requester funds
		seize(deal.requester, requesterstake, _taskid);
		// dapp reward
		if (deal.app.price > 0)
		{
			reward(deal.app.owner, deal.app.price, _taskid);
		}
		// data reward
		if (deal.dataset.price > 0 && deal.dataset.pointer != address(0))
		{
			reward(deal.dataset.owner, deal.dataset.price, _taskid);
		}
		// unlock pool stake
		unlock(deal.workerpool.owner, poolstake);
		// pool reward performed by consensus manager

		/**
		 * Retrieve part of the kitty
		 * TODO: remove / keep ?
		 */
		uint256 kitty = m_frozens[KITTY_ADDRESS];
		if (kitty > 0)
		{
			kitty = kitty
			        .percentage(KITTY_RATIO) // fraction
			        .max(KITTY_MIN)          // at least this
			        .min(kitty);             // but not more than available
			seize (KITTY_ADDRESS,         kitty, _taskid);
			reward(deal.workerpool.owner, kitty, _taskid);
		}
	}

	function failedWork(bytes32 _dealid, bytes32 _taskid)
	internal
	{
		IexecLibCore_v5.Deal storage deal = m_deals[_dealid];

		uint256 requesterstake = deal.app.price
		                         .add(deal.dataset.price)
		                         .add(deal.workerpool.price);
		uint256 poolstake = deal.workerpool.price
		                    .percentage(WORKERPOOL_STAKE_RATIO);

		unlock(deal.requester,        requesterstake    );
		seize (deal.workerpool.owner, poolstake, _taskid);
		reward(KITTY_ADDRESS,         poolstake, _taskid); // → Kitty / Burn
		lock  (KITTY_ADDRESS,         poolstake         ); // → Kitty / Burn
	}

	/***************************************************************************
	 *                           ODB order signature                           *
	 ***************************************************************************/
	

	

	

	/***************************************************************************
	 *                           ODB order matching                            *
	 ***************************************************************************/
	struct Identities
	{
		bytes32 appHash;
		address appOwner;
		bytes32 datasetHash;
		address datasetOwner;
		bytes32 workerpoolHash;
		address workerpoolOwner;
		bytes32 requestHash;
		bool    hasDataset;
	}

	// should be external
	

	/***************************************************************************
	 *                            Consensus methods                            *
	 ***************************************************************************/
	

	// TODO: making it external causes "stack too deep" error
	

	

	

	

	function claim(
		bytes32 _taskid)
	public override
	{
		IexecLibCore_v5.Task storage task = m_tasks[_taskid];
		require(task.status == IexecLibCore_v5.TaskStatusEnum.ACTIVE
		     || task.status == IexecLibCore_v5.TaskStatusEnum.REVEALING);
		require(task.finalDeadline <= now);

		task.status = IexecLibCore_v5.TaskStatusEnum.FAILLED;

		/**
		 * Stake management
		 */
		failedWork(task.dealid, _taskid);
		for (uint256 i = 0; i < task.contributors.length; ++i)
		{
			address worker = task.contributors[i];
			unlockContribution(task.dealid, worker);
		}

		emit TaskClaimed(_taskid);
	}

	// New
	// TODO: making it external causes "stack too deep" error
	function contributeAndFinalize(
		bytes32      _taskid,
		bytes32      _resultDigest,
		bytes memory _results,
		address      _enclaveChallenge,
		bytes memory _enclaveSign,
		bytes memory _authorizationSign)
	public override
	{
		IexecLibCore_v5.Task         storage task         = m_tasks[_taskid];
		IexecLibCore_v5.Contribution storage contribution = m_contributions[_taskid][_msgSender()];
		IexecLibCore_v5.Deal         memory  deal         = m_deals[task.dealid];

		require(task.status               == IexecLibCore_v5.TaskStatusEnum.ACTIVE);
		require(task.contributionDeadline >  now                                  );
		require(task.contributors.length  == 0                                    );
		require(deal.trust                == 1                                    ); // TODO, consider sender's score ?

		bytes32 resultHash = keccak256(abi.encodePacked(              _taskid, _resultDigest));
		bytes32 resultSeal = keccak256(abi.encodePacked(_msgSender(), _taskid, _resultDigest));

		require(deal.callback == address(0) || keccak256(_results) == _resultDigest);

		// need enclave challenge if tag is set
		require(_enclaveChallenge != address(0) || (deal.tag[31] & 0x01 == 0));

		// Check that the worker + taskid + enclave combo is authorized to contribute (scheduler signature)
		require(_checkSignature(
			( _enclaveChallenge != address(0) && m_teebroker != address(0) ) ? m_teebroker : deal.workerpool.owner,
			keccak256(abi.encodePacked(
				_msgSender(),
				_taskid,
				_enclaveChallenge
			)).toEthSignedMessageHash(),
			_authorizationSign
		));

		// Check enclave signature
		require(_enclaveChallenge == address(0) || _checkSignature(
			_enclaveChallenge,
			keccak256(abi.encodePacked(
				resultHash,
				resultSeal
			)).toEthSignedMessageHash(),
			_enclaveSign
		));

		contribution.status           = IexecLibCore_v5.ContributionStatusEnum.PROVED;
		contribution.resultHash       = resultHash;
		contribution.resultSeal       = resultSeal;
		contribution.enclaveChallenge = _enclaveChallenge;

		task.status                   = IexecLibCore_v5.TaskStatusEnum.COMPLETED;
		task.consensusValue           = contribution.resultHash;
		task.revealDeadline           = task.timeref.mul(REVEAL_DEADLINE_RATIO).add(now);
		task.revealCounter            = 1;
		task.winnerCounter            = 1;
		task.resultDigest             = _resultDigest;
		task.results                  = _results;
		task.contributors.push(_msgSender());

		successWork(task.dealid, _taskid);

		// simple reward, no score consideration
		uint256 workerReward    = deal.workerpool.price.percentage(uint256(100).sub(deal.schedulerRewardRatio));
		uint256 schedulerReward = deal.workerpool.price.sub(workerReward);
		rewardForContribution(_msgSender(), workerReward, _taskid);
		rewardForScheduling(task.dealid, schedulerReward, _taskid);

		emit TaskContribute(_taskid, _msgSender(), resultHash);
		emit TaskConsensus(_taskid, resultHash);
		emit TaskReveal(_taskid, _msgSender(), _resultDigest);
		emit TaskFinalize(_taskid, _results);

		executeCallback(_taskid, _results);
	}

	/***************************************************************************
	 *                       Internal Consensus methods                        *
	 ***************************************************************************/
	/*
	 * Consensus detection
	 */
	function checkConsensus(
		bytes32 _taskid,
		bytes32 _consensus)
	internal
	{
		IexecLibCore_v5.Consensus storage consensus = m_consensus[_taskid];

		uint256 trust = m_deals[m_tasks[_taskid].dealid].trust;
		if (consensus.group[_consensus].mul(trust) > consensus.total.mul(trust.sub(1)))
		{
			// Preliminary checks done in "contribute()"

			IexecLibCore_v5.Task storage task = m_tasks[_taskid];
			uint256 winnerCounter = 0;
			for (uint256 i = 0; i < task.contributors.length; ++i)
			{
				address w = task.contributors[i];
				if
				(
					m_contributions[_taskid][w].resultHash == _consensus
					&&
					m_contributions[_taskid][w].status == IexecLibCore_v5.ContributionStatusEnum.CONTRIBUTED // REJECTED contribution must not be count
				)
				{
					winnerCounter = winnerCounter.add(1);
				}
			}
			// _msgSender() is a contributor: no need to check
			// require(winnerCounter > 0);
			task.status         = IexecLibCore_v5.TaskStatusEnum.REVEALING;
			task.consensusValue = _consensus;
			task.revealDeadline = task.timeref.mul(REVEAL_DEADLINE_RATIO).add(now);
			task.revealCounter  = 0;
			task.winnerCounter  = winnerCounter;

			emit TaskConsensus(_taskid, _consensus);
		}
	}

	/*
	 * Reward distribution
	 */
	function distributeRewards(bytes32 _taskid)
	internal
	{
		IexecLibCore_v5.Task storage task = m_tasks[_taskid];
		IexecLibCore_v5.Deal memory  deal = m_deals[task.dealid];

		uint256 totalLogWeight = 0;
		uint256 totalReward    = deal.workerpool.price;

		for (uint256 i = 0; i < task.contributors.length; ++i)
		{
			address                              worker       = task.contributors[i];
			IexecLibCore_v5.Contribution storage contribution = m_contributions[_taskid][worker];

			if (contribution.status == IexecLibCore_v5.ContributionStatusEnum.PROVED)
			{
				totalLogWeight = totalLogWeight.add(contribution.weight);
			}
			else // ContributionStatusEnum.REJECT or ContributionStatusEnum.CONTRIBUTED (not revealed)
			{
				totalReward = totalReward.add(deal.workerStake);
			}
		}

		// compute how much is going to the workers
		uint256 workersReward = totalReward.percentage(uint256(100).sub(deal.schedulerRewardRatio));

		for (uint256 i = 0; i < task.contributors.length; ++i)
		{
			address                              worker       = task.contributors[i];
			IexecLibCore_v5.Contribution storage contribution = m_contributions[_taskid][worker];

			if (contribution.status == IexecLibCore_v5.ContributionStatusEnum.PROVED)
			{
				uint256 workerReward = workersReward.mulByFraction(contribution.weight, totalLogWeight);
				totalReward          = totalReward.sub(workerReward);

				unlockContribution(task.dealid, worker);
				rewardForContribution(worker, workerReward, _taskid);

				// Only reward if replication happened
				if (task.contributors.length > 1)
				{
					/*******************************************************************
					 *                        SCORE POLICY 2/3                         *
					 *                                                                 *
					 *                       see documentation!                        *
					 *******************************************************************/
					m_workerScores[worker] = m_workerScores[worker].add(1);
					emit AccurateContribution(worker, _taskid);
				}
			}
			else // WorkStatusEnum.POCO_REJECT or ContributionStatusEnum.CONTRIBUTED (not revealed)
			{
				// No Reward
				seizeContribution(task.dealid, worker, _taskid);

				// Always punish bad contributors
				{
					/*******************************************************************
					 *                        SCORE POLICY 3/3                         *
					 *                                                                 *
					 *                       see documentation!                        *
					 *******************************************************************/
					// k = 3
					m_workerScores[worker] = m_workerScores[worker].mulByFraction(2,3);
					emit FaultyContribution(worker, _taskid);
				}
			}
		}
		// totalReward now contains the scheduler share
		rewardForScheduling(task.dealid, totalReward, _taskid);
	}

	/**
	 * Callback for smartcontracts using EIP1154
	 */
	function executeCallback(bytes32 _taskid, bytes memory _results)
	internal
	{
		address target = m_deals[m_tasks[_taskid].dealid].callback;
		if (target != address(0))
		{
			/**
			 * Call does not revert if the target smart contract is incompatible or reverts
			 * Solidity 0.6.0 update. Check hit history for 0.5.0 implementation.
			 */
			try IOracleConsumer(target).receiveResult.gas(m_callbackgas)(_taskid, _results)
			{
				// Callback success, do nothing
			}
			catch (bytes memory /*lowLevelData*/)
			{
				// Check gas: https://ronan.eth.link/blog/ethereum-gas-dangers/
				assert(gasleft() > m_callbackgas / 63); // no need for safemath here
			}
		}
	}

	/***************************************************************************
	 *                            Array operations                             *
	 ***************************************************************************/
	function initializeArray(
		bytes32[] calldata _dealid,
		uint256[] calldata _idx)
	external override returns (bool)
	{
		require(_dealid.length == _idx.length);
		for (uint i = 0; i < _dealid.length; ++i)
		{
			initialize(_dealid[i], _idx[i]);
		}
		return true;
	}

	function claimArray(
		bytes32[] calldata _taskid)
	external override returns (bool)
	{
		for (uint i = 0; i < _taskid.length; ++i)
		{
			claim(_taskid[i]);
		}
		return true;
	}

	function initializeAndClaimArray(
		bytes32[] calldata _dealid,
		uint256[] calldata _idx)
	external override returns (bool)
	{
		require(_dealid.length == _idx.length);
		for (uint i = 0; i < _dealid.length; ++i)
		{
			claim(initialize(_dealid[i], _idx[i]));
		}
		return true;
	}
}
