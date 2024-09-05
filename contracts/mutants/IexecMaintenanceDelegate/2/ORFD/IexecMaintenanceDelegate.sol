pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

import "../DelegateBase.sol";
import "../interfaces/IexecMaintenance.sol";


contract IexecMaintenanceDelegate is IexecMaintenance, DelegateBase
{
	using SafeMathExtended  for uint256;
	using IexecLibOrders_v5 for IexecLibOrders_v5.EIP712Domain;

	

	

	function updateDomainSeparator()
	external override
	{
		require(EIP712DOMAIN_SEPARATOR != bytes32(0), "not-configured");
		EIP712DOMAIN_SEPARATOR = _domain().hash();
	}

	function importScore(address _worker)
	external override
	{
		require(!m_v3_scoreImported[_worker], "score-already-imported");
		m_workerScores[_worker] = m_workerScores[_worker].max(m_v3_iexecHub.viewScore(_worker));
		m_v3_scoreImported[_worker] = true;
	}

	function setTeeBroker(address _teebroker)
	external override onlyOwner()
	{
		m_teebroker = _teebroker;
	}

	function setCallbackGas(uint256 _callbackgas)
	external override onlyOwner()
	{
		m_callbackgas = _callbackgas;
	}

	function _chainId()
	internal pure returns (uint256 id)
	{
		assembly { id := chainid() }
	}

	function _domain()
	internal view returns (IexecLibOrders_v5.EIP712Domain memory)
	{
		return IexecLibOrders_v5.EIP712Domain({
			name:              "iExecODB"
		, version:           "3.0-alpha"
		, chainId:           _chainId()
		, verifyingContract: address(this)
		});
	}
}
