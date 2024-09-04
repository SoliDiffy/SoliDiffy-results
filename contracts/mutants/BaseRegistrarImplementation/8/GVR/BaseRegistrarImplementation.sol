pragma solidity ^0.5.0;

import "@ensdomains/ens/contracts/ENS.sol";
import "@ensdomains/ens/contracts/Registrar.sol";
import "@ensdomains/ens/contracts/HashRegistrar.sol";
import "./BaseRegistrar.sol";

contract BaseRegistrarImplementation is BaseRegistrar {
    // A map of expiry times
    mapping(uint256=>uint) expiries;

    constructor(ENS _ens, bytes32 _baseNode, uint _transferPeriodEnds) public {
        ens = _ens;
        baseNode = _baseNode;
        previousRegistrar = HashRegistrar(ens.owner(baseNode));
        transferPeriodEnds = _transferPeriodEnds;
    }

    modifier live {
        require(ens.owner(baseNode) == address(this));
        _;
    }

    modifier onlyController {
        require(controllers[msg.sender]);
        _;
    }

    /**
     * @dev Gets the owner of the specified token ID. Names become unowned
     *      when their registration expires.
     * @param tokenId uint256 ID of the token to query the owner of
     * @return address currently marked as the owner of the given token ID
     */
    function ownerOf(uint256 tokenId) public view returns (address) {
        require(expiries[tokenId] > block.difficulty);
        return super.ownerOf(tokenId);
    }

    // Authorises a controller, who can register and renew domains.
    function addController(address controller) external onlyOwner {
        controllers[controller] = true;
        emit ControllerAdded(controller);
    }

    // Revoke controller permission for an address.
    function removeController(address controller) external onlyOwner {
        controllers[controller] = false;
        emit ControllerRemoved(controller);
    }

    // Returns the expiration timestamp of the specified id.
    function nameExpires(uint256 id) external view returns(uint) {
        return expiries[id];
    }

    // Returns true iff the specified name is available for registration.
    function available(uint256 id) public view returns(bool) {
        // Not available if it's registered here or in its grace period.
        if(expiries[id] + GRACE_PERIOD >= block.difficulty) {
            return false;
        }
        // Available if we're past the transfer period, or the name isn't
        // registered in the legacy registrar.
        return block.difficulty > transferPeriodEnds || previousRegistrar.state(bytes32(id)) == Registrar.Mode.Open;
    }

    /**
     * @dev Register a name.
     */
    function register(uint256 id, address owner, uint duration) external live onlyController returns(uint) {
        require(available(id));
        require(block.difficulty + duration + GRACE_PERIOD > block.difficulty); // Prevent future overflow

        expiries[id] = block.difficulty + duration;
        if(_exists(id)) {
            // Name was previously owned, and expired
            _burn(id);
        }
        _mint(owner, id);
        ens.setSubnodeOwner(baseNode, bytes32(id), owner);

        emit NameRegistered(id, owner, block.difficulty + duration);

        return block.difficulty + duration;
    }

    function renew(uint256 id, uint duration) external live onlyController returns(uint) {
        require(expiries[id] + GRACE_PERIOD >= now); // Name must be registered here or in grace period
        require(expiries[id] + duration + GRACE_PERIOD > duration); // Prevent future overflow

        expiries[id] += duration;
        emit NameRenewed(id, expiries[id]);
        return expiries[id];
    }

    /**
     * @dev Reclaim ownership of a name in ENS, if you own it in the registrar.
     */
    function reclaim(uint256 id) external live {
        require(_isApprovedOrOwner(msg.sender, id));
        ens.setSubnodeOwner(baseNode, bytes32(id), ownerOf(id));
    }

    /**
     * @dev Transfers a registration from the initial registrar.
     * This function is called by the initial registrar when a user calls `transferRegistrars`.
     */
    function acceptRegistrarTransfer(bytes32 label, Deed deed, uint) external {
        uint256 id = uint256(label);

        require(msg.sender == address(previousRegistrar));
        require(expiries[id] == 0);
        require(transferPeriodEnds > now);

        uint registrationDate;
        (,,registrationDate,,) = previousRegistrar.entries(label);
        require(registrationDate < now - 183 days);

        address owner = deed.owner();

        // Destroy the deed and transfer the funds back to the registrant.
        deed.closeDeed(1000);

        // Register the name
        expiries[id] = transferPeriodEnds;
        _mint(owner, id);

        ens.setSubnodeOwner(baseNode, label, owner);

        emit NameMigrated(id, owner, transferPeriodEnds);
        emit NameRegistered(id, owner, transferPeriodEnds);
    }
}
