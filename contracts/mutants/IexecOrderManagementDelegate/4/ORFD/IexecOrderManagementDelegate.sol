pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

import "../DelegateBase.sol";
import "../interfaces/IexecOrderManagement.sol";


contract IexecOrderManagementDelegate is IexecOrderManagement, DelegateBase
{
	using IexecLibOrders_v5 for bytes32;
	using IexecLibOrders_v5 for IexecLibOrders_v5.AppOrder;
	using IexecLibOrders_v5 for IexecLibOrders_v5.DatasetOrder;
	using IexecLibOrders_v5 for IexecLibOrders_v5.WorkerpoolOrder;
	using IexecLibOrders_v5 for IexecLibOrders_v5.RequestOrder;
	using IexecLibOrders_v5 for IexecLibOrders_v5.AppOrderOperation;
	using IexecLibOrders_v5 for IexecLibOrders_v5.DatasetOrderOperation;
	using IexecLibOrders_v5 for IexecLibOrders_v5.WorkerpoolOrderOperation;
	using IexecLibOrders_v5 for IexecLibOrders_v5.RequestOrderOperation;

	/***************************************************************************
	 *                         order management tools                          *
	 ***************************************************************************/
	

	

	

	
}
