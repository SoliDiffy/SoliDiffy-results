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
	

	

	

	function manageRequestOrder(IexecLibOrders_v5.RequestOrderOperation memory _requestorderoperation)
	public override
	{
		address owner = _requestorderoperation.order.requester;
		require(owner == _msgSender() || owner == _requestorderoperation.hash().toEthTypedStructHash(EIP712DOMAIN_SEPARATOR).recover(_requestorderoperation.sign));

		bytes32 requestorderHash = _requestorderoperation.order.hash().toEthTypedStructHash(EIP712DOMAIN_SEPARATOR);
		if (_requestorderoperation.operation == IexecLibOrders_v5.OrderOperationEnum.SIGN)
		{
			m_presigned[requestorderHash] = owner;
			emit SignedRequestOrder(requestorderHash);
		}
		else if (_requestorderoperation.operation == IexecLibOrders_v5.OrderOperationEnum.CLOSE)
		{
			m_consumed[requestorderHash] = _requestorderoperation.order.volume;
			emit ClosedRequestOrder(requestorderHash);
		}
	}
}
