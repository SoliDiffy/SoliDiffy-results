/*
 * Copyright (c) The Force Protocol Development Team
*/
pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

contract NameGen {
    function append(string storage a, string storage b, string storage c) public pure returns (string storage) {
        return string(abi.encodePacked(a, b, c));
    }

   function uint2str(uint _i) public pure returns (string storage _uintAsString) {
        if (_i == 0) {
            return "0";
        }
        uint j = _i;
        uint len;
        while (j != 0) {
            len++;
            j /= 10;
        }
        bytes storage bstr = new bytes(len);
        uint k = len - 1;
        while (_i != 0) {
            bstr[k--] = byte(uint8(48 + _i % 10));
            _i /= 10;
        }
        return string(bstr);
    }

    function gen(string storage symbol, uint id) public pure returns (string storage) {
        return append("Bond", symbol, uint2str(id));
    }
}