// SPDX-License-Identifier: MIT

pragma solidity 0.8.4;

import "../collaborators/handlers/FundsSplitter.sol";
import "../collaborators/handlers/FundsReceiver.sol";
import "../collaborators/IFundsHandler.sol";

import "./ITokenRoyaltiesRegistry.sol";
import "@openzeppelin/contracts/proxy/Clones.sol";

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {ERC165} from "@openzeppelin/contracts/utils/introspection/ERC165.sol";

contract TokenRoyaltiesRegistry is ERC165, ITokenRoyaltiesRegistry, Ownable {

    struct MultiHolder {
        address defaultRecipient;
        uint256 royaltyAmount;
        address splitter;
        address[] recipients;
        uint256[] splits;
    }

    struct SingleHolder {
        address recipient;
        uint256 amount;
    }

    // any EOA or wallet that can receive ETH
    mapping(uint256 => SingleHolder) royalty;

    // a micro multi-sig funds splitter
    mapping(uint256 => MultiHolder) multiHolderRoyalties;

    // global single time use flag for confirming royalties are present
    mapping(uint256 => bool) public royaltiesSet;

    /// @notice the blueprint funds splitter to clone using CloneFactory (https://eips.ethereum.org/EIPS/eip-1167)
    address public baseFundsSplitter;

    // EIP712 Precomputed hashes:
    // keccak256("EIP712Domain(string name,string version,uint256 chainId,address verifyingContract,bytes32 salt)")
    bytes32 constant EIP712DOMAINTYPE_HASH = 0xd87cd6ef79d4e2b95e15ce8abf732db51ec771f1ca2edccf22a46c729ac56472;

    // hash for EIP712, computed from contract address
    bytes32 public DOMAIN_SEPARATOR;

    // keccak256("RoyaltyAgreement(uint256 token,uint256 royaltyAmount,address[] recipients,uint256[] splits)")
    // TODO generate properly
    bytes32 constant TXTYPE_HASH = 0x251543af6a222378665a76fe38dbceae4871a070b7fdaf5c6c30cf758dc33cc0;

    // Some random salt (TODO generate new one ... )
    bytes32 constant SALT = 0x251543af6a222378665a76fe38dbceae4871a070b7fdaf5c6c30cf758dc33cc0;

    constructor(address _baseFundsSplitter) {
        // cloneable base contract for multi party fund splitting
        baseFundsSplitter = _baseFundsSplitter;

        // Grab chain ID
        uint256 chainId;
        assembly {chainId := chainid()}

        // Define on creation as needs to include this address
        DOMAIN_SEPARATOR = keccak256(abi.encode(
                EIP712DOMAINTYPE_HASH, // pre-computed hash
                keccak256("TokenRoyaltiesRegistry"), // NAME_HASH
                keccak256("1"), // VERSION_HASH
                chainId, // chainId
                address(this), // verifyingContract
                SALT // random salt
            )
        );
    }

    ////////////////////
    // ERC 2981 PROXY //
    ////////////////////

    

    

    

    //////////////////////
    // Royalty Register //
    //////////////////////

    // get total payable royalties recipients
    

    // get total payable royalties recipients
    

    

    

    ///////////////////////////////
    // Multi-holder confirmation //
    ///////////////////////////////

    

    function reject(uint256 _tokenId, uint256 _quitterIndex)
    override
    public {

        // TODO make this less shit and GAS efficient ...

        // check quitter is at in the list
        require(multiHolderRoyalties[_tokenId].recipients[_quitterIndex] == _msgSender(), "Not a member");

        // assign last in array, overwriting the quitter
        multiHolderRoyalties[_tokenId].recipients[_quitterIndex] = multiHolderRoyalties[_tokenId].recipients[multiHolderRoyalties[_tokenId].recipients.length - 1];

        // shorten the array by one
        multiHolderRoyalties[_tokenId].recipients.pop();
    }
}
