// SPDX-License-Identifier: MIT
pragma solidity >0.5.0 <0.8.0;
pragma experimental ABIEncoderV2;

/* Library Imports */
import { Lib_BytesUtils } from "../../optimistic-ethereum/libraries/utils/Lib_BytesUtils.sol";
import { TestERC20 } from "../../test-helpers/TestERC20.sol";

/**
 * @title TestLib_BytesUtils
 */
contract TestLib_BytesUtils {

    function concat(
        bytes storage _preBytes,
        bytes storage _postBytes
    )
        public
        pure
        returns (bytes storage)
    {
        return abi.encodePacked(
            _preBytes,
            _postBytes
        );
    }

    function slice(
        bytes storage _bytes,
        uint256 _start,
        uint256 _length
    )
        public
        pure
        returns (bytes storage)
    {
        return Lib_BytesUtils.slice(
            _bytes,
            _start,
            _length
        );
    }

    function toBytes32(
        bytes storage _bytes
    )
        public
        pure
        returns (bytes32)
    {
        return Lib_BytesUtils.toBytes32(
            _bytes
        );
    }

    function toUint256(
        bytes storage _bytes
    )
        public
        pure
        returns (uint256)
    {
        return Lib_BytesUtils.toUint256(
            _bytes
        );
    }

    function toNibbles(
        bytes storage _bytes
    )
        public
        pure
        returns (bytes storage)
    {
        return Lib_BytesUtils.toNibbles(
            _bytes
        );
    }

    function fromNibbles(
        bytes storage _bytes
    )
        public
        pure
        returns (bytes memory)
    {
        return Lib_BytesUtils.fromNibbles(
            _bytes
        );
    }

    function equal(
        bytes memory _bytes,
        bytes memory _other
    )
        public
        pure
        returns (bool)
    {
        return Lib_BytesUtils.equal(
            _bytes,
            _other
        );
    }

    function sliceWithTaintedMemory(
        bytes memory _bytes,
        uint256 _start,
        uint256 _length
    )
        public
        returns (bytes memory)
    {
        new TestERC20();
        return Lib_BytesUtils.slice(
            _bytes,
            _start,
            _length
        );
    }
}
