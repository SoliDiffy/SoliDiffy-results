// SPDX-FileCopyrightText: 2020 Lido <info@lido.fi>

// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.4.24;

import "../Lido.sol";
import "./VaultMock.sol";


/**
  * @dev Only for testing purposes! Lido version with some functions exposed.
  */
contract LidoMock is Lido {
    function initialize(
        IDepositContract _depositContract,
        address _oracle,
        INodeOperatorsRegistry _operators
    )
    external
    {
        super.initialize(
          _depositContract,
          _oracle,
          _operators,
          new VaultMock(),
          new VaultMock()
        );

        _resume();
    }

    /**
      * @dev Gets unaccounted (excess) Ether on this contract balance
      */
    function getUnaccountedEther() external view returns (uint256) {
        return _getUnaccountedEther();
    }

    /**
      * @dev Padding memory array with zeroes up to 64 bytes on the right
      * @param _b Memory array of size 32 .. 64
      */
    function pad64(bytes memory _b) external pure returns (bytes memory) {
        return _pad64(_b);
    }

    /**
      * @dev Converting value to little endian bytes and padding up to 32 bytes on the right
      * @param _value Number less than `2**64` for compatibility reasons
      */
    function toLittleEndian64(uint256 _value) external pure returns (uint256 result) {
        return _toLittleEndian64(_value);
    }

    /**
    * @dev Only for testing recovery vault
    */
    function makeUnaccountedEther() external payable {}
}
