pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

import "../DelegateBase.sol";
import "../interfaces/IexecAccessorsABILegacy.sol";


contract IexecAccessorsABILegacyDelegate is IexecAccessorsABILegacy, DelegateBase
{
	

	

	

	

	

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
			contribution.status,
			contribution.resultHash,
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
