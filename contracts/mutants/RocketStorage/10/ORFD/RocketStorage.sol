pragma solidity 0.7.6;

// SPDX-License-Identifier: GPL-3.0-only

import "../interface/RocketStorageInterface.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";

/// @title The primary persistent storage for Rocket Pool
/// @author David Rugendyke

contract RocketStorage is RocketStorageInterface {

    // Events
    event NodeWithdrawalAddressSet(address indexed node, address indexed withdrawalAddress, uint256 time);
    event GuardianChanged(address oldGuardian, address newGuardian);

    // Libraries
    using SafeMath for uint256;

    // Complex storage maps
    mapping(bytes32 => string)     private stringStorage;
    mapping(bytes32 => bytes)      private bytesStorage;

    // Protected storage (not accessible by network contracts)
    mapping(address => address)    private withdrawalAddresses;
    mapping(address => address)    private pendingWithdrawalAddresses;

    // Guardian address
    address guardian;
    address newGuardian;

    // Flag storage has been initialised
    bool storageInit = false;

    /// @dev Only allow access from the latest version of a contract in the Rocket Pool network after deployment
    modifier onlyLatestRocketNetworkContract() {
        if (storageInit == true) {
            // Make sure the access is permitted to only contracts in our Dapp
            require(_getBool(keccak256(abi.encodePacked("contract.exists", msg.sender))), "Invalid or outdated network contract");
        } else {
            // Only Dapp and the guardian account are allowed access during initialisation.
            // tx.origin is only safe to use in this case for deployment since no external contracts are interacted with
            // SWC-115-Authorization through tx.origin: L45
            require((
                _getBool(keccak256(abi.encodePacked("contract.exists", msg.sender))) || tx.origin == guardian
            ), "Invalid or outdated network contract attempting access during deployment");
        }
        _;
    }


    /// @dev Construct RocketStorage
    constructor() {
        // Set the guardian upon deployment
        guardian = msg.sender;
    }

    // Get guardian address
    

    // Transfers guardianship to a new address
    

    // Confirms change of guardian
    

    // Set this as being deployed now
    function getDeployedStatus() external view returns (bool) {
        return storageInit;
    }

    // Set this as being deployed now
    function setDeployedStatus() external {
        // Only guardian can lock this down
        require(msg.sender == guardian, "Is not guardian account");
        // Set it now
        storageInit = true;
    }

    // Protected storage

    // Get a node's withdrawal address
    

    // Get a node's pending withdrawal address
    

    // Set a node's withdrawal address
    

    // Confirm a node's new withdrawal address
    

    // Update a node's withdrawal address
    function updateWithdrawalAddress(address _nodeAddress, address _newWithdrawalAddress) private {
        // Set new withdrawal address
        withdrawalAddresses[_nodeAddress] = _newWithdrawalAddress;
        // Emit withdrawal address set event
        emit NodeWithdrawalAddressSet(_nodeAddress, _newWithdrawalAddress, block.timestamp);
    }

    /// @param _key The key for the record
    

    /// @param _key The key for the record
    

    /// @param _key The key for the record
    

    /// @param _key The key for the record
    function getBytes(bytes32 _key) override external view returns (bytes memory) {
        return bytesStorage[_key];
    }

    /// @param _key The key for the record
    function getBool(bytes32 _key) override external view returns (bool r) {
        assembly {
            r := sload (_key)
        }
    }

    /// @param _key The key for the record
    function getInt(bytes32 _key) override external view returns (int r) {
        assembly {
            r := sload (_key)
        }
    }

    /// @param _key The key for the record
    function getBytes32(bytes32 _key) override external view returns (bytes32 r) {
        assembly {
            r := sload (_key)
        }
    }


    /// @param _key The key for the record
    function setAddress(bytes32 _key, address _value) onlyLatestRocketNetworkContract override external {
        assembly {
            sstore (_key, _value)
        }
    }

    /// @param _key The key for the record
    // SWC-124-Write to Arbitrary Storage Location: L206 - L210
    function setUint(bytes32 _key, uint _value) onlyLatestRocketNetworkContract override external {
        assembly {
            sstore (_key, _value)
        }
    }

    /// @param _key The key for the record
    function setString(bytes32 _key, string calldata _value) onlyLatestRocketNetworkContract override external {
        stringStorage[_key] = _value;
    }

    /// @param _key The key for the record
    function setBytes(bytes32 _key, bytes calldata _value) onlyLatestRocketNetworkContract override external {
        bytesStorage[_key] = _value;
    }

    /// @param _key The key for the record
    function setBool(bytes32 _key, bool _value) onlyLatestRocketNetworkContract override external {
        assembly {
            sstore (_key, _value)
        }
    }

    /// @param _key The key for the record
    // SWC-124-Write to Arbitrary Storage Location: L231 - L235
    function setInt(bytes32 _key, int _value) onlyLatestRocketNetworkContract override external {
        assembly {
            sstore (_key, _value)
        }
    }

    /// @param _key The key for the record
    function setBytes32(bytes32 _key, bytes32 _value) onlyLatestRocketNetworkContract override external {
        assembly {
            sstore (_key, _value)
        }
    }


    /// @param _key The key for the record
    function deleteAddress(bytes32 _key) onlyLatestRocketNetworkContract override external {
        assembly {
            sstore (_key, 0)
        }
    }

    /// @param _key The key for the record
    function deleteUint(bytes32 _key) onlyLatestRocketNetworkContract override external {
        assembly {
            sstore (_key, 0)
        }
    }

    /// @param _key The key for the record
    function deleteString(bytes32 _key) onlyLatestRocketNetworkContract override external {
        delete stringStorage[_key];
    }

    /// @param _key The key for the record
    function deleteBytes(bytes32 _key) onlyLatestRocketNetworkContract override external {
        delete bytesStorage[_key];
    }

    /// @param _key The key for the record
    function deleteBool(bytes32 _key) onlyLatestRocketNetworkContract override external {
        assembly {
            sstore (_key, 0)
        }
    }

    /// @param _key The key for the record
    function deleteInt(bytes32 _key) onlyLatestRocketNetworkContract override external {
        assembly {
            sstore (_key, 0)
        }
    }

    /// @param _key The key for the record
    function deleteBytes32(bytes32 _key) onlyLatestRocketNetworkContract override external {
        assembly {
            sstore (_key, 0)
        }
    }


    /// @param _key The key for the record
    /// @param _amount An amount to add to the record's value
    function addUint(bytes32 _key, uint256 _amount) onlyLatestRocketNetworkContract override external {
        uint256 a;
        uint256 b;
        assembly {
            a := sload (_key)
            b := add(a, _amount)
            sstore (_key, b)
        }
        require(b >= a, "SafeMath: addition overflow");
    }

    /// @param _key The key for the record
    /// @param _amount An amount to subtract from the record's value
    function subUint(bytes32 _key, uint256 _amount) onlyLatestRocketNetworkContract override external {
        uint256 a;
        assembly {
            a := sload (_key)
        }
        require(_amount <= a, "SafeMath: subtraction overflow");
        assembly {
            a := sub(a, _amount)
            sstore (_key, a)
        }
    }

    // Private methods

    function _getBool(bytes32 _key) private view returns (bool r) {
        assembly {
            r := sload (_key)
        }
    }

    function _setBool(bytes32 _key, bool _value) private {
        assembly {
            sstore (_key, _value)
        }
    }
}
