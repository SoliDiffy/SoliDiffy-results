// SPDX-License-Identifier: BUSL-1.1

pragma solidity 0.7.6;

import "./interfaces/ILayerZeroReceiver.sol";
import "./interfaces/ILayerZeroEndpoint.sol";
import "./interfaces/ILayerZeroMessagingLibrary.sol";

import "@openzeppelin/contracts/access/Ownable.sol";

contract Endpoint is Ownable, ILayerZeroEndpoint {
    uint16 public immutable chainId;

    // installed libraries and reserved versions
    uint16 public constant BLOCK_VERSION = 65535;
    uint16 public constant DEFAULT_VERSION = 0;
    uint16 public latestVersion;
    mapping(uint16 => ILayerZeroMessagingLibrary) public libraryLookup; // version -> ILayerZeroEndpointLibrary

    // default send/receive libraries
    uint16 public defaultSendVersion;
    uint16 public defaultReceiveVersion;
    ILayerZeroMessagingLibrary public defaultSendLibrary;
    address public defaultReceiveLibraryAddress;

    struct LibraryConfig {
        uint16 sendVersion;
        uint16 receiveVersion;
        address receiveLibraryAddress;
        ILayerZeroMessagingLibrary sendLibrary;
    }

    struct StoredPayload {
        uint64 payloadLength;
        address dstAddress;
        bytes32 payloadHash;
    }

    // user app config = [uaAddress]
    mapping(address => LibraryConfig) public uaConfigLookup;
    // inboundNonce = [srcChainId][srcAddress].
    mapping(uint16 => mapping(bytes => uint64)) public inboundNonce;
    // outboundNonce = [dstChainId][srcAddress].
    mapping(uint16 => mapping(address => uint64)) public outboundNonce;
    // storedPayload = [srcChainId][srcAddress]
    mapping(uint16 => mapping(bytes => StoredPayload)) public storedPayload;

    // library versioning events
    event NewLibraryVersionAdded(uint16 version);
    event DefaultSendVersionSet(uint16 version);
    event DefaultReceiveVersionSet(uint16 version);
    event UaSendVersionSet(address ua, uint16 version);
    event UaReceiveVersionSet(address ua, uint16 version);
    event UaForceResumeReceive(uint16 chainId, bytes srcAddress);
    // payload events
    event PayloadCleared(uint16 srcChainId, bytes srcAddress, uint64 nonce, address dstAddress);
    event PayloadStored(uint16 srcChainId, bytes srcAddress, address dstAddress, uint64 nonce, bytes payload, bytes reason);

    constructor(uint16 _chainId) {
        chainId = _chainId;
    }

    //---------------------------------------------------------------------------
    // send and receive nonreentrant lock
    uint8 internal constant _NOT_ENTERED = 1;
    uint8 internal constant _ENTERED = 2;
    uint8 internal _send_entered_state = 1;
    uint8 internal _receive_entered_state = 1;

    modifier sendNonReentrant() {
        require(_send_entered_state == _NOT_ENTERED, "LayerZero: no send reentrancy");
        _send_entered_state = _ENTERED;
        _;
        _send_entered_state = _NOT_ENTERED;
    }
    modifier receiveNonReentrant() {
        require(_receive_entered_state == _NOT_ENTERED, "LayerZero: no receive reentrancy");
        _receive_entered_state = _ENTERED;
        _;
        _receive_entered_state = _NOT_ENTERED;
    }

    // BLOCK_VERSION is also a valid version
    modifier validVersion(uint16 _version) {
        require(_version <= latestVersion || _version == BLOCK_VERSION, "LayerZero: invalid messaging library version");
        _;
    }

    //---------------------------------------------------------------------------
    // User Application Calls - Endpoint Interface

    

    //---------------------------------------------------------------------------
    // authenticated Library (msg.sender) Calls to pass through Endpoint to UA (dstAddress)
    

    

    //---------------------------------------------------------------------------
    // Owner Calls, only new library version upgrade (3 steps)

    // note libraryLookup[0] = 0x0, no library implementation
    // LIBRARY UPGRADE step 1: set _newLayerZeroLibraryAddress be the new version
    function newVersion(address _newLayerZeroLibraryAddress) external onlyOwner {
        require(_newLayerZeroLibraryAddress != address(0x0), "LayerZero: new version cannot be zero address");
        // SWC-101-Integer Overflow and Underflow: L152
        require(latestVersion < 65535, "LayerZero: can not add new messaging library");
        latestVersion++;
        libraryLookup[latestVersion] = ILayerZeroMessagingLibrary(_newLayerZeroLibraryAddress);
        emit NewLibraryVersionAdded(latestVersion);
    }

    // LIBRARY UPGRADE step 2: stop sending messages from the old version
    function setDefaultSendVersion(uint16 _newDefaultSendVersion) external onlyOwner validVersion(_newDefaultSendVersion) {
        require(_newDefaultSendVersion != DEFAULT_VERSION, "LayerZero: default send version must > 0");
        defaultSendVersion = _newDefaultSendVersion;
        defaultSendLibrary = libraryLookup[defaultSendVersion];
        emit DefaultSendVersionSet(_newDefaultSendVersion);
    }

    // LIBRARY UPGRADE step 3: stop receiving messages from the old version
    function setDefaultReceiveVersion(uint16 _newDefaultReceiveVersion) external onlyOwner validVersion(_newDefaultReceiveVersion) {
        require(_newDefaultReceiveVersion != DEFAULT_VERSION, "LayerZero: default receive version must > 0");
        defaultReceiveVersion = _newDefaultReceiveVersion;
        defaultReceiveLibraryAddress = address(libraryLookup[defaultReceiveVersion]);
        emit DefaultReceiveVersionSet(_newDefaultReceiveVersion);
    }

    //---------------------------------------------------------------------------
    // User Application Calls - UA set/get Interface

    

    // Migration step 1: set the send version
    // Define what library the UA points too
    

    // Migration step 2: set the receive version
    // after all messages sent from the old version are received
    // the UA can now safely switch to the new receive version
    // it is the UA's responsibility make sure all messages from the old version are processed
    

    function forceResumeReceive(uint16 _srcChainId, bytes calldata _srcAddress) external override {
        StoredPayload storage sp = storedPayload[_srcChainId][_srcAddress];
        // revert if no messages are cached. safeguard malicious UA behaviour
        require(sp.payloadHash != bytes32(0), "LayerZero: no stored payload");
        require(sp.dstAddress == msg.sender, "LayerZero: invalid caller");

        // empty the storedPayload
        sp.payloadLength = 0;
        sp.dstAddress = address(0);
        sp.payloadHash = bytes32(0);

        // emit the event with the new nonce
        emit UaForceResumeReceive(_srcChainId, _srcAddress);
    }

    //---------------------------------------------------------------------------
    // view helper function

    function estimateFees(uint16 _dstChainId, address _userApplication, bytes calldata _payload, bool _payInZRO, bytes calldata _adapterParams) external view override returns (uint nativeFee, uint zroFee) {
        LibraryConfig storage uaConfig = uaConfigLookup[_userApplication];
        ILayerZeroMessagingLibrary lib = uaConfig.sendVersion == DEFAULT_VERSION ? defaultSendLibrary : uaConfig.sendLibrary;
        return lib.estimateFees(_dstChainId, _userApplication, _payload, _payInZRO, _adapterParams);
    }

    function _getSendLibrary(LibraryConfig storage uaConfig) internal view returns (ILayerZeroMessagingLibrary) {
        if (uaConfig.sendVersion == DEFAULT_VERSION) {
            // check if the in send-blocking upgrade
            require(defaultSendVersion != BLOCK_VERSION, "LayerZero: default in BLOCK_VERSION");
            return defaultSendLibrary;
        } else {
            // check if the in send-blocking upgrade
            require(uaConfig.sendVersion != BLOCK_VERSION, "LayerZero: in BLOCK_VERSION");
            return uaConfig.sendLibrary;
        }
    }

    function getSendLibraryAddress(address _userApplication) external view override returns (address sendLibraryAddress) {
        LibraryConfig storage uaConfig = uaConfigLookup[_userApplication];
        uint16 sendVersion = uaConfig.sendVersion;
        require(sendVersion != BLOCK_VERSION, "LayerZero: send version is BLOCK_VERSION");
        if (sendVersion == DEFAULT_VERSION) {
            require(defaultSendVersion != BLOCK_VERSION, "LayerZero: send version (default) is BLOCK_VERSION");
            sendLibraryAddress = address(defaultSendLibrary);
        } else {
            sendLibraryAddress = address(uaConfig.sendLibrary);
        }
    }

    function getReceiveLibraryAddress(address _userApplication) external view override returns (address receiveLibraryAddress) {
        LibraryConfig storage uaConfig = uaConfigLookup[_userApplication];
        uint16 receiveVersion = uaConfig.receiveVersion;
        require(receiveVersion != BLOCK_VERSION, "LayerZero: receive version is BLOCK_VERSION");
        if (receiveVersion == DEFAULT_VERSION) {
            require(defaultReceiveVersion != BLOCK_VERSION, "LayerZero: receive version (default) is BLOCK_VERSION");
            receiveLibraryAddress = defaultReceiveLibraryAddress;
        } else {
            receiveLibraryAddress = uaConfig.receiveLibraryAddress;
        }
    }

    function isSendingPayload() external view override returns (bool) {
        return _send_entered_state == _ENTERED;
    }

    function isReceivingPayload() external view override returns (bool) {
        return _receive_entered_state == _ENTERED;
    }

    function getInboundNonce(uint16 _srcChainId, bytes calldata _srcAddress) external view override returns (uint64) {
        return inboundNonce[_srcChainId][_srcAddress];
    }

    function getOutboundNonce(uint16 _dstChainId, address _srcAddress) external view override returns (uint64) {
        return outboundNonce[_dstChainId][_srcAddress];
    }

    function getChainId() external view override returns (uint16) {
        return chainId;
    }

    function getSendVersion(address _userApplication) external view override returns (uint16) {
        LibraryConfig storage uaConfig = uaConfigLookup[_userApplication];
        return uaConfig.sendVersion == DEFAULT_VERSION ? defaultSendVersion : uaConfig.sendVersion;
    }

    function getReceiveVersion(address _userApplication) external view override returns (uint16) {
        LibraryConfig storage uaConfig = uaConfigLookup[_userApplication];
        return uaConfig.receiveVersion == DEFAULT_VERSION ? defaultReceiveVersion : uaConfig.receiveVersion;
    }

    function getConfig(uint16 _version, uint16 _chainId, address _userApplication, uint _configType) external view override validVersion(_version) returns (bytes memory) {
        if (_version == DEFAULT_VERSION) {
            require(defaultSendVersion == defaultReceiveVersion, "LayerZero: no DEFAULT config while migration");
            _version = defaultSendVersion;
        }
        require(_version != BLOCK_VERSION, "LayerZero: can not get config for BLOCK_VERSION");
        return libraryLookup[_version].getConfig(_chainId, _userApplication, _configType);
    }

    function hasStoredPayload(uint16 _srcChainId, bytes calldata _srcAddress) external view override returns (bool) {
        StoredPayload storage sp = storedPayload[_srcChainId][_srcAddress];
        return sp.payloadHash != bytes32(0);
    }
}
