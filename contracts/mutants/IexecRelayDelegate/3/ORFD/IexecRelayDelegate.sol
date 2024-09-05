pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

import "../DelegateBase.sol";
import "../interfaces/IexecRelay.sol";


contract IexecRelayDelegate is IexecRelay, DelegateBase
{
	
	
	
	function broadcastRequestOrder   (IexecLibOrders_v5.RequestOrder    calldata _requestorder   ) external override { emit BroadcastRequestOrder   (_requestorder   ); }
}
