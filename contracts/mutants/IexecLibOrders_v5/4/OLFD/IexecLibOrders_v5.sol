pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;


library IexecLibOrders_v5
{
	bytes32 public constant             EIP712DOMAIN_TYPEHASH = keccak256("EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)");
	bytes32 public constant                 APPORDER_TYPEHASH = keccak256("AppOrder(address app,uint256 appprice,uint256 volume,bytes32 tag,address datasetrestrict,address workerpoolrestrict,address requesterrestrict,bytes32 salt)"); // TODO: uint256 expiry
	bytes32 public constant             DATASETORDER_TYPEHASH = keccak256("DatasetOrder(address dataset,uint256 datasetprice,uint256 volume,bytes32 tag,address apprestrict,address workerpoolrestrict,address requesterrestrict,bytes32 salt)"); // TODO: uint256 expiry
	bytes32 public constant          WORKERPOOLORDER_TYPEHASH = keccak256("WorkerpoolOrder(address workerpool,uint256 workerpoolprice,uint256 volume,bytes32 tag,uint256 category,uint256 trust,address apprestrict,address datasetrestrict,address requesterrestrict,bytes32 salt)"); // TODO: uint256 expiry
	bytes32 public constant             REQUESTORDER_TYPEHASH = keccak256("RequestOrder(address app,uint256 appmaxprice,address dataset,uint256 datasetmaxprice,address workerpool,uint256 workerpoolmaxprice,address requester,uint256 volume,bytes32 tag,uint256 category,uint256 trust,address beneficiary,address callback,string params,bytes32 salt)"); // TODO: uint256 expiry
	bytes32 public constant        APPORDEROPERATION_TYPEHASH = keccak256("AppOrderOperation(AppOrder order,uint256 operation)AppOrder(address app,uint256 appprice,uint256 volume,bytes32 tag,address datasetrestrict,address workerpoolrestrict,address requesterrestrict,bytes32 salt)");
	bytes32 public constant    DATASETORDEROPERATION_TYPEHASH = keccak256("DatasetOrderOperation(DatasetOrder order,uint256 operation)DatasetOrder(address dataset,uint256 datasetprice,uint256 volume,bytes32 tag,address apprestrict,address workerpoolrestrict,address requesterrestrict,bytes32 salt)");
	bytes32 public constant WORKERPOOLORDEROPERATION_TYPEHASH = keccak256("WorkerpoolOrderOperation(WorkerpoolOrder order,uint256 operation)WorkerpoolOrder(address workerpool,uint256 workerpoolprice,uint256 volume,bytes32 tag,uint256 category,uint256 trust,address apprestrict,address datasetrestrict,address requesterrestrict,bytes32 salt)");
	bytes32 public constant    REQUESTORDEROPERATION_TYPEHASH = keccak256("RequestOrderOperation(RequestOrder order,uint256 operation)RequestOrder(address app,uint256 appmaxprice,address dataset,uint256 datasetmaxprice,address workerpool,uint256 workerpoolmaxprice,address requester,uint256 volume,bytes32 tag,uint256 category,uint256 trust,address beneficiary,address callback,string params,bytes32 salt)");

	enum OrderOperationEnum
	{
		SIGN,
		CLOSE
	}

	struct EIP712Domain
	{
		string  name;
		string  version;
		uint256 chainId;
		address verifyingContract;
	}

	struct AppOrder
	{
		address app;
		uint256 appprice;
		uint256 volume;
		bytes32 tag;
		address datasetrestrict;
		address workerpoolrestrict;
		address requesterrestrict;
		// uint256 expiration; // TODO: order evolution - deadlines
		bytes32 salt;
		bytes   sign;
	}

	struct DatasetOrder
	{
		address dataset;
		uint256 datasetprice;
		uint256 volume;
		bytes32 tag;
		address apprestrict;
		address workerpoolrestrict;
		address requesterrestrict;
		// uint256 expiration; // TODO: order evolution - deadlines
		bytes32 salt;
		bytes   sign;
	}

	struct WorkerpoolOrder
	{
		address workerpool;
		uint256 workerpoolprice;
		uint256 volume;
		bytes32 tag;
		uint256 category;
		uint256 trust;
		address apprestrict;
		address datasetrestrict;
		address requesterrestrict;
		// uint256 expiration; // TODO: order evolution - deadlines
		bytes32 salt;
		bytes   sign;
	}

	struct RequestOrder
	{
		address app;
		uint256 appmaxprice;
		address dataset;
		uint256 datasetmaxprice;
		address workerpool;
		uint256 workerpoolmaxprice;
		address requester;
		uint256 volume;
		bytes32 tag;
		uint256 category;
		uint256 trust;
		address beneficiary;
		address callback;
		string  params;
		// uint256 expiration; // TODO: order evolution - deadlines
		bytes32 salt;
		bytes   sign;
	}

	struct AppOrderOperation
	{
		AppOrder           order;
		OrderOperationEnum operation;
		bytes              sign;
	}

	struct DatasetOrderOperation
	{
		DatasetOrder       order;
		OrderOperationEnum operation;
		bytes              sign;
	}

	struct WorkerpoolOrderOperation
	{
		WorkerpoolOrder    order;
		OrderOperationEnum operation;
		bytes              sign;
	}

	struct RequestOrderOperation
	{
		RequestOrder       order;
		OrderOperationEnum operation;
		bytes              sign;
	}

	

	

	

	

	function hash(RequestOrder memory _requestorder)
	public pure returns (bytes32 requesthash)
	{
		/**
		 * Readeable but expensive
		 */
		//return keccak256(abi.encodePacked(
		//	abi.encode(
		//		REQUESTORDER_TYPEHASH
		//	, _requestorder.app
		//	, _requestorder.appmaxprice
		//	, _requestorder.dataset
		//	, _requestorder.datasetmaxprice
		//	, _requestorder.workerpool
		//	, _requestorder.workerpoolmaxprice
		//	, _requestorder.requester
		//	, _requestorder.volume
		//	, _requestorder.tag
		//	, _requestorder.category
		//	, _requestorder.trust
		//	, _requestorder.beneficiary
		//	, _requestorder.callback
		//	, keccak256(bytes(_requestorder.params))
		//	, _requestorder.salt
		//	)
		//));

		// Compute sub-hashes
		bytes32 typeHash = REQUESTORDER_TYPEHASH;
		bytes32 paramsHash = keccak256(bytes(_requestorder.params));
		assembly {
			// Back up select memory
			let temp1 := mload(sub(_requestorder, 0x020))
			let temp2 := mload(add(_requestorder, 0x1A0))
			// Write typeHash and sub-hashes
			mstore(sub(_requestorder, 0x020), typeHash)
			mstore(add(_requestorder, 0x1A0), paramsHash)
			// Compute hash
			requesthash := keccak256(sub(_requestorder, 0x20), 0x200) // TODO: order evolution - 0x200→0x220
			// Restore memory
			mstore(sub(_requestorder, 0x020), temp1)
			mstore(add(_requestorder, 0x1A0), temp2)
		}
	}

	function hash(AppOrderOperation memory _apporderoperation)
	public pure returns (bytes32)
	{
		return keccak256(abi.encode(
			APPORDEROPERATION_TYPEHASH,
			hash(_apporderoperation.order),
			_apporderoperation.operation
		));
	}

	function hash(DatasetOrderOperation memory _datasetorderoperation)
	public pure returns (bytes32)
	{
		return keccak256(abi.encode(
			DATASETORDEROPERATION_TYPEHASH,
			hash(_datasetorderoperation.order),
			_datasetorderoperation.operation
		));
	}

	function hash(WorkerpoolOrderOperation memory _workerpoolorderoperation)
	public pure returns (bytes32)
	{
		return keccak256(abi.encode(
			WORKERPOOLORDEROPERATION_TYPEHASH,
			hash(_workerpoolorderoperation.order),
			_workerpoolorderoperation.operation
		));
	}

	function hash(RequestOrderOperation memory _requestorderoperation)
	public pure returns (bytes32)
	{
		return keccak256(abi.encode(
			REQUESTORDEROPERATION_TYPEHASH,
			hash(_requestorderoperation.order),
			_requestorderoperation.operation
		));
	}

	function toEthSignedMessageHash(bytes32 _msgHash)
	public pure returns (bytes32)
	{
		return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", _msgHash));
	}

	function toEthTypedStructHash(bytes32 _structHash, bytes32 _domainHash)
	public pure returns (bytes32 typedStructHash)
	{
		return keccak256(abi.encodePacked("\x19\x01", _domainHash, _structHash));
	}

	function recover(bytes32 _hash, bytes memory _sign)
	public pure returns (address)
	{
		bytes32 r;
		bytes32 s;
		uint8   v;

		if (_sign.length == 65) // 65bytes: (r,s,v) form
		{
			assembly
			{
				r :=         mload(add(_sign, 0x20))
				s :=         mload(add(_sign, 0x40))
				v := byte(0, mload(add(_sign, 0x60)))
			}
		}
		else if (_sign.length == 64) // 64bytes: (r,vs) form → see EIP2098
		{
			assembly
			{
				r :=                mload(add(_sign, 0x20))
				s := and(           mload(add(_sign, 0x40)), 0x7fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff)
				v := shr(7, byte(0, mload(add(_sign, 0x40))))
			}
		}
		else
		{
			revert("invalid-signature-format");
		}

		if (v < 27) v += 27;
		require(v == 27 || v == 28, "invalid-signature-v");
		return ecrecover(_hash, v, r, s);
	}
}
