// SPDX-License-Identifier: MIT

pragma solidity 0.6.9;

import "../extensions/IAmpTokensSender.sol";

import "./AmpPartitionStrategyValidatorBase.sol";


interface IAmp {
    function isCollateralManager(address) external view returns (bool);

    function isOperatorForCollateralManager(
        bytes32,
        address,
        address
    ) external view returns (bool);
}


/**
 * @notice Partition strategy validator contract for collateral managers that
 * need to have arbitration control over partitions in the token holder's
 * address.
 * @dev This contract manages partitions that begin with the prefix 0xAAAAAAAA.
 * For those partitions, the last 20 bytes of the partition represent the
 * address of the collateral manager that "owns" the partition range. This
 * address is referred to as the "partition owner". Upon a transfer from
 * a partition in the scope of this strategy, the "AmpTokensSender" transfer
 * hook of the partition owner will be called. This allows the collateral
 * manager to restrict a transfer, even if it is not "from" it's address, if any
 * tokens in it's owned collateral partitions should not be moved by the holder.
 *
 * The partition owner, as well as its operators, are given permission to
 * call `Amp.operatorTransferByPartition` for any address for any partition
 * within it's owned space.
 *
 * The middle 8 bytes can be used by the collateral manager implementation for
 * any additional sub partitioning that it desires.
 */
contract HolderCollateralPartitionValidator is AmpPartitionStrategyValidatorBase {
    bytes4 constant PARTITION_FLAG = 0xAAAAAAAA;

    string internal constant AMP_TOKENS_SENDER = "AmpTokensSender";

    constructor(address _amp)
        public
        AmpPartitionStrategyValidatorBase(PARTITION_FLAG, _amp)
    {}

    /**
     * @notice Check if `_operator` address is an operator for the `_partition`
     * based on the strategy.
     * @dev For this partition flag, the `_tokenHolder` address is the supplier,
     * and the operator is the collateral manager (or an operator for the
     * collateral manager address in case the CM contract itself has given
     * those permissions to a different account).
     * The last 20 bytes of the partition is address of the CM, and the
     * operator provided must have permissions for that address.
     * @param _operator Address to check.
     * @param _partition Partition to check if `_operator` address is an
     * operator for.
     */
    

    /**
     * @notice Validate the rules of the strategy when tokens are being sent
     * from a partition under the purview of this strategy.
     * @dev Partition space is used for Collateral managers that have control
     * over all partitions in their space (defined by 0xAAAAAAAA flag and their
     * address as the last 20 bytes), so they can implement the AmpTokensSender
     * hook to revert a transaction submitted to transfer tokens from a
     * partition in their space.
     * @param _functionSig The function sig of the calling function.
     * @param _fromPartition The partition the transfer is from.
     * @param _operator The operator of the transfer.
     * @param _from The owner of the tokens being transferred.
     * @param _to The address the tokens are being transferred to.
     * @param _value The amount of tokens being transferred.
     * @param _data Additional metadata attached to the transfer.
     * @param _operatorData Addtitional metadata attached to the transfer on
     * behalf of the operator.
     */
    

    /**
     * @notice Validate the rules of the strategy when tokens are being sent
     * to a partition under the purview of this strategy.
     * @dev Revert if the partition owner of the partition is not a collateral
     * manager, or if the `_to` address is the partition owner, as this strategy
     * is for collateral managers that store the tokens at the holder address.
     * @param _toPartition The partition the transfer is to.
     * @param _to The address the tokens are being transferred to.
     * behalf of the operator.
     */
    
}
