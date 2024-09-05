pragma solidity ^0.4.24;

/**
 * @notice Contract to store important enumerators
 * @author Nikola Madjarevic
 */
contract TwoKeyConversionStates {
    enum ConversionState {APPROVED, PENDING_APPROVAL, EXECUTED, REJECTED, CANCELLED_BY_CONVERTER}
}
