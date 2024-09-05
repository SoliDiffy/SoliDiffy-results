// SPDX-License-Identifier: AGPL-3.0-only

pragma solidity 0.7.5;
pragma abicoder v2;

import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "../presets/OwnablePausable.sol";
import "../interfaces/IDepositContract.sol";
import "../interfaces/IValidators.sol";
import "../interfaces/ISolos.sol";

/**
 * @title Solos
 *
 * @dev Users can create standalone validators with their own withdrawal key using this contract.
 * The validator can be registered as soon as deposit is added.
 */
contract Solos is ISolos, ReentrancyGuard, OwnablePausable {
    using Address for address payable;
    using SafeMath for uint256;

    // @dev Validator deposit amount.
    uint256 public constant VALIDATOR_DEPOSIT = 32 ether;

    // @dev Maps ID of the solo to its information.
    mapping(bytes32 => Solo) public override solos;

    // @dev Address of the ETH2 Deposit Contract (deployed by Ethereum).
    IDepositContract public override validatorRegistration;

    // @dev Solo validator price per month.
    uint256 public override validatorPrice;

    // @dev Solo validator deposit cancel lock duration.
    uint256 public override cancelLockDuration;

    // @dev Address of the Validators contract.
    IValidators private validators;

    /**
    * @dev Constructor for initializing the Solos contract.
    * @param _admin - address of the contract admin.
    * @param _validatorRegistration - address of the VRC (deployed by Ethereum).
    * @param _validators - address of the Validators contract.
    * @param _validatorPrice - validator price.
    * @param _cancelLockDuration - cancel lock duration in seconds.
    */
    constructor(
        address _admin,
        address _validatorRegistration,
        address _validators,
        uint256 _validatorPrice,
        uint256 _cancelLockDuration
    )
        OwnablePausable(_admin)
    {
        validatorRegistration = IDepositContract(_validatorRegistration);
        validators = IValidators(_validators);

        // set validator price
        validatorPrice = _validatorPrice;
        emit ValidatorPriceUpdated(_validatorPrice);

        // set cancel lock duration
        cancelLockDuration = _cancelLockDuration;
        emit CancelLockDurationUpdated(_cancelLockDuration);
    }

    /**
     * @dev See {ISolos-addDeposit}.
     */
    

    /**
     * @dev See {ISolos-cancelDeposit}.
     */
    

    /**
     * @dev See {ISolos-setValidatorPrice}.
     */
    

    /**
     * @dev See {ISolos-setCancelLockDuration}.
     */
    

    /**
     * @dev See {ISolos-registerValidator}.
     */
    
}
