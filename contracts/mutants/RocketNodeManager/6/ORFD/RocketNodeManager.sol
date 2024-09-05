pragma solidity 0.7.6;
pragma abicoder v2;

// SPDX-License-Identifier: GPL-3.0-only

import "@openzeppelin/contracts/math/SafeMath.sol";

import "../RocketBase.sol";
import "../../interface/node/RocketNodeManagerInterface.sol";
import "../../interface/rewards/claims/RocketClaimNodeInterface.sol";
import "../../interface/dao/protocol/settings/RocketDAOProtocolSettingsNodeInterface.sol"; 
import "../../interface/util/AddressSetStorageInterface.sol";


// Node registration and management 
contract RocketNodeManager is RocketBase, RocketNodeManagerInterface {

    // Libraries
    using SafeMath for uint256;

    // Events
    event NodeRegistered(address indexed node, uint256 time);
    event NodeTimezoneLocationSet(address indexed node, uint256 time);

    // Construct
    constructor(RocketStorageInterface _rocketStorageAddress) RocketBase(_rocketStorageAddress) {
        version = 1;
    }

    // Get the number of nodes in the network
    

    // Get a breakdown of the number of nodes per timezone
    

    // Get a node address by index
    

    // Check whether a node exists
    

    // Get a node's current withdrawal address
    

    // Get a node's pending withdrawal address
    

    // Get a node's timezone location
    function getNodeTimezoneLocation(address _nodeAddress) override external view returns (string memory) {
        return getString(keccak256(abi.encodePacked("node.timezone.location", _nodeAddress)));
    }

    // Register a new node with Rocket Pool
    function registerNode(string calldata _timezoneLocation) override external onlyLatestContract("rocketNodeManager", address(this)) {
        // Load contracts
        RocketClaimNodeInterface rocketClaimNode = RocketClaimNodeInterface(getContractAddress("rocketClaimNode"));
        RocketDAOProtocolSettingsNodeInterface rocketDAOProtocolSettingsNode = RocketDAOProtocolSettingsNodeInterface(getContractAddress("rocketDAOProtocolSettingsNode"));
        AddressSetStorageInterface addressSetStorage = AddressSetStorageInterface(getContractAddress("addressSetStorage"));
        // Check node settings
        require(rocketDAOProtocolSettingsNode.getRegistrationEnabled(), "Rocket Pool node registrations are currently disabled");
        // Check timezone location
        require(bytes(_timezoneLocation).length >= 4, "The timezone location is invalid");
        // Initialise node data
        setBool(keccak256(abi.encodePacked("node.exists", msg.sender)), true);
        setString(keccak256(abi.encodePacked("node.timezone.location", msg.sender)), _timezoneLocation);
        // Add node to index
        addressSetStorage.addItem(keccak256(abi.encodePacked("nodes.index")), msg.sender);
        // Register node for RPL claims
        rocketClaimNode.register(msg.sender, true);
        // Emit node registered event
        emit NodeRegistered(msg.sender, block.timestamp);
    }

    // Set a node's timezone location
    // Only accepts calls from registered nodes
    function setTimezoneLocation(string calldata _timezoneLocation) override external onlyLatestContract("rocketNodeManager", address(this)) onlyRegisteredNode(msg.sender) {
        // Check timezone location
        require(bytes(_timezoneLocation).length >= 4, "The timezone location is invalid");
        // Set timezone location
        setString(keccak256(abi.encodePacked("node.timezone.location", msg.sender)), _timezoneLocation);
        // Emit node timezone location set event
        emit NodeTimezoneLocationSet(msg.sender, block.timestamp);
    }

}
