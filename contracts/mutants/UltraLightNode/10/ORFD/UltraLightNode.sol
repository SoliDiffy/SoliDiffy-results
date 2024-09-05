// SPDX-License-Identifier: BUSL-1.1

pragma solidity 0.7.6;
pragma abicoder v2;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/SafeERC20.sol";

import "@layerzerolabs/proof-evm/contracts/ILayerZeroValidationLibrary.sol";

import "./interfaces/ILayerZeroMessagingLibrary.sol";
import "./interfaces/ILayerZeroReceiver.sol";
import "./interfaces/ILayerZeroRelayer.sol";
import "./interfaces/ILayerZeroTreasury.sol";
import "./interfaces/ILayerZeroOracle.sol";
import "./interfaces/ILayerZeroUltraLightNodeV1.sol";
import "./interfaces/ILayerZeroEndpoint.sol";

contract UltraLightNode is ILayerZeroMessagingLibrary, ILayerZeroUltraLightNodeV1, ReentrancyGuard, Ownable {
    using SafeERC20 for IERC20;
    using SafeMath for uint;

    struct BlockData {
        uint confirmations;
        bytes32 data;
    }

    // Application config
    uint public constant CONFIG_TYPE_INBOUND_PROOF_LIBRARY_VERSION = 1;
    uint public constant CONFIG_TYPE_INBOUND_BLOCK_CONFIRMATIONS = 2;
    uint public constant CONFIG_TYPE_RELAYER = 3;
    uint public constant CONFIG_TYPE_OUTBOUND_PROOF_TYPE = 4;
    uint public constant CONFIG_TYPE_OUTBOUND_BLOCK_CONFIRMATIONS = 5;
    uint public constant CONFIG_TYPE_ORACLE = 6;

    struct ApplicationConfiguration {
        uint16 inboundProofLibraryVersion;
        uint64 inboundBlockConfirmations;
        address relayer;
        uint16 outboundProofType;
        uint64 outboundBlockConfirmations;
        address oracle;
    }

    // Token and Contracts
    IERC20 public layerZeroToken;
    ILayerZeroTreasury public treasuryContract;

    // Fee management
    uint public constant BP_DENOMINATOR = 10000;
    // treasury and relayer share the protocol fee, either in native token or ZRO
    uint8 public constant WITHDRAW_TYPE_TREASURY_PROTOCOL_FEES = 0;
    uint8 public constant WITHDRAW_TYPE_ORACLE_QUOTED_FEES = 1; // quoted fee refers to the fee in block relaying
    uint8 public constant WITHDRAW_TYPE_RELAYER_QUOTED_FEES = 2; //quoted fee refers the fee in msg relaying

    mapping(address => uint) public oracleQuotedFees;
    mapping(address => uint) public relayerQuotedFees;
    uint public treasuryNativeFees;
    uint public treasuryZROFees;

    // User Application
    mapping(address => mapping(uint16 => ApplicationConfiguration)) public appConfig; // app address => chainId => config
    mapping(uint16 => ApplicationConfiguration) public defaultAppConfig; // default UA settings if no version specified
    mapping(uint16 => mapping(uint16 => bytes)) public defaultAdapterParams;

    // Validation
    mapping(uint16 => mapping(uint16 => address)) public inboundProofLibrary; // chainId => library Id => inboundProofLibrary contract
    mapping(uint16 => uint16) public maxInboundProofLibrary; // chainId => inboundProofLibrary
    mapping(uint16 => mapping(uint16 => bool)) public supportedOutboundProof; // chainId => outboundProofType => enabled
    mapping(uint16 => uint) public chainAddressSizeMap;
    mapping(address => mapping(uint16 => mapping(bytes32 => BlockData))) public hashLookup;
    mapping(uint16 => bytes32) public ulnLookup; // remote ulns

    ILayerZeroEndpoint public immutable endpoint;

    // Events
    event AppConfigUpdated(address userApplication, uint configType, bytes newConfig);
    event AddInboundProofLibraryForChain(uint16 chainId, address lib);
    event EnableSupportedOutboundProof(uint16 chainId, uint16 proofType);
    event HashReceived(uint16 srcChainId, address oracle, uint confirmations, bytes32 blockhash);
    event Packet(uint16 chainId, bytes payload);
    event RelayerParams(uint16 chainId, uint64 nonce, uint16 outboundProofType, bytes adapterParams);
    event SetChainAddressSize(uint16 chainId, uint size);
    event SetDefaultConfigForChainId(uint16 chainId, uint16 inboundProofLib, uint64 inboundBlockConfirm, address relayer, uint16 outboundProofType, uint16 outboundBlockConfirm, address oracle);
    event SetDefaultAdapterParamsForChainId(uint16 chainId, uint16 proofType, bytes adapterParams);
    event SetLayerZeroToken(address tokenAddress);
    event SetRelayerFeeContract(address relayerFeeContract);
    event SetRemoteUln(uint16 chainId, bytes32 uln);
    event SetTreasury(address treasuryAddress);
    event WithdrawZRO(address _msgSender, address _to, uint _amount);
    event WithdrawNative(uint8 _type, address _owner, address _msgSender, address _to, uint _amount);

    constructor(address _endpoint) {
        require(_endpoint != address(0x0), "LayerZero: endpoint cannot be zero address");
        endpoint = ILayerZeroEndpoint(_endpoint);
    }

    // only the endpoint can call SEND() and setConfig()
    modifier onlyEndpoint() {
        require(address(endpoint) == msg.sender, "LayerZero: only endpoint");
        _;
    }

    //----------------------------------------------------------------------------------
    // PROTOCOL

    // This function completes delivery of a LayerZero message.
    //
    // In order to deliver the message, this function:
    // (a) takes the _transactionProof submitted by UA's relayer, and
    // (b) retrieve UA's validation library
    // (c) takes the _blockData submitted by the UA's oracle given the their configuration (and blockConfirmations),
    // (d) decodes using UA's validation library using (a) and (c)
    //  then, this functions asserts that
    // (e) the payload originated from the known Ultra Light Node from source chain, and
    // (f) the _dstAddress the specified destination contract
    

    // Called (by the Endpoint) with the information required to send a LayerZero message for a User Application.
    // This function:
    // (a) pays the protocol (native token or ZRO), oracle (native token) and relayer (native token) for their roles in sending the message.
    // (b) generates the message payload and emits events of the message and adapterParams
    // (c) notifies the oracle
    

    // Can be called by any address to update a block header
    // can only upload new block data or the same block data with more confirmations
    

    //----------------------------------------------------------------------------------
    // Other Library Interfaces

    // default to DEFAULT setting if ZERO value
    function getAppConfig(uint16 _chainId, address userApplicationAddress) public view returns (ApplicationConfiguration memory) {
        ApplicationConfiguration memory config = appConfig[userApplicationAddress][_chainId];
        ApplicationConfiguration storage defaultConfig = defaultAppConfig[_chainId];

        if (config.inboundProofLibraryVersion == 0) {
            config.inboundProofLibraryVersion = defaultConfig.inboundProofLibraryVersion;
        }

        if (config.inboundBlockConfirmations == 0) {
            config.inboundBlockConfirmations = defaultConfig.inboundBlockConfirmations;
        }

        if (config.relayer == address(0x0)) {
            config.relayer = defaultConfig.relayer;
        }

        if (config.outboundProofType == 0) {
            config.outboundProofType = defaultConfig.outboundProofType;
        }

        if (config.outboundBlockConfirmations == 0) {
            config.outboundBlockConfirmations = defaultConfig.outboundBlockConfirmations;
        }

        if (config.oracle == address(0x0)) {
            config.oracle = defaultConfig.oracle;
        }

        return config;
    }

    

    

    // returns the native fee the UA pays to cover fees
    

    //---------------------------------------------------------------------------
    // Claim Fees

    // universal withdraw ZRO token function
    

    // universal withdraw native token function.
    // the source contract should perform all the authentication control
    // safemath overflow if the amount is not enough
    

    //---------------------------------------------------------------------------
    // Owner calls, configuration only.
    function setLayerZeroToken(address _layerZeroToken) external onlyOwner {
        require(_layerZeroToken != address(0x0), "LayerZero: _layerZeroToken cannot be zero address");
        layerZeroToken = IERC20(_layerZeroToken);
        emit SetLayerZeroToken(_layerZeroToken);
    }

    function setTreasury(address _treasury) external onlyOwner {
        require(_treasury != address(0x0), "LayerZero: treasury cannot be zero address");
        treasuryContract = ILayerZeroTreasury(_treasury);
        emit SetTreasury(_treasury);
    }

    function addInboundProofLibraryForChain(uint16 _chainId, address _library) external onlyOwner {
        require(_library != address(0x0), "LayerZero: library cannot be zero address");
        require(maxInboundProofLibrary[_chainId] < 65535, "LayerZero: can not add new library");
        maxInboundProofLibrary[_chainId]++;
        inboundProofLibrary[_chainId][maxInboundProofLibrary[_chainId]] = _library;
        emit AddInboundProofLibraryForChain(_chainId, _library);
    }

    function enableSupportedOutboundProof(uint16 _chainId, uint16 _proofType) external onlyOwner {
        supportedOutboundProof[_chainId][_proofType] = true;
        emit EnableSupportedOutboundProof(_chainId, _proofType);
    }

    function setDefaultConfigForChainId(uint16 _chainId, uint16 _inboundProofLibraryVersion, uint64 _inboundBlockConfirmations, address _relayer, uint16 _outboundProofType, uint16 _outboundBlockConfirmations, address _oracle) external onlyOwner {
        require(_inboundProofLibraryVersion <= maxInboundProofLibrary[_chainId] && _inboundProofLibraryVersion > 0, "LayerZero: invalid inbound proof library version");
        require(_inboundBlockConfirmations > 0, "LayerZero: invalid inbound block confirmation");
        require(_relayer != address(0x0), "LayerZero: invalid relayer address");
        require(supportedOutboundProof[_chainId][_outboundProofType], "LayerZero: invalid outbound proof type");
        require(_outboundBlockConfirmations > 0, "LayerZero: invalid outbound block confirmation");
        require(_oracle != address(0x0), "LayerZero: invalid oracle address");
        defaultAppConfig[_chainId] = ApplicationConfiguration(_inboundProofLibraryVersion, _inboundBlockConfirmations, _relayer, _outboundProofType, _outboundBlockConfirmations, _oracle);
        emit SetDefaultConfigForChainId(_chainId, _inboundProofLibraryVersion, _inboundBlockConfirmations, _relayer, _outboundProofType, _outboundBlockConfirmations, _oracle);
    }

    function setDefaultAdapterParamsForChainId(uint16 _chainId, uint16 _proofType, bytes calldata _adapterParams) external onlyOwner {
        defaultAdapterParams[_chainId][_proofType] = _adapterParams;
        emit SetDefaultAdapterParamsForChainId(_chainId, _proofType, _adapterParams);
    }

    function setRemoteUln(uint16 _remoteChainId, bytes32 _remoteUln) external onlyOwner {
        require(ulnLookup[_remoteChainId] == bytes32(0), "LayerZero: remote uln already set");
        ulnLookup[_remoteChainId] = _remoteUln;
        emit SetRemoteUln(_remoteChainId, _remoteUln);
    }

    function setChainAddressSize(uint16 _chainId, uint _size) external onlyOwner {
        require(chainAddressSizeMap[_chainId] == 0, "LayerZero: remote chain address size already set");
        chainAddressSizeMap[_chainId] = _size;
        emit SetChainAddressSize(_chainId, _size);
    }

    //----------------------------------------------------------------------------------
    // view functions
    function getBlockHeaderData(address _oracle, uint16 _remoteChainId, bytes32 _lookupHash) external view returns (BlockData memory blockData) {
        return hashLookup[_oracle][_remoteChainId][_lookupHash];
    }

    

    
}
