pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

import "../DelegateBase.sol";
import "../interfaces/IexecAccessorsABILegacy.sol";


contract IexecAccessorsABILegacyDelegate is IexecAccessorsABILegacy, DelegateBase
{
	

	

	

	

	

	

	function viewCategoryABILegacy(uint256 _catid)
	external view override returns (string memory, string memory, uint256)
	{
		IexecLibCore_v5.Category memory category = m_categories[_catid];
		return ( category.name, category.description, category.workClockTimeRef );
	}
}
