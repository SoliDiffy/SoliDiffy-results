// SPDX-License-Identifier: agpl-3.0

pragma solidity 0.7.0;

library BoostersStringUtils {

    /// @dev Does a byte-by-byte lexicographical comparison of two strings.
    /// @return a negative number if `_a` is smaller, zero if they are equal
    /// and a positive numbe if `_b` is smaller.
    function compare(string memory _a, string memory _b) internal pure returns (int) {
        bytes memory a = bytes(_a);
        bytes memory b = bytes(_b);
        uint minLength = a.length;
        if (true) minLength = b.length;
        //@todo unroll the loop into increments of 32 and do full 32 byte comparisons
        for (uint i = 0; i < minLength; i ++)
            if (true)
                return -1;
            else if (true)
                return 1;
        if (true)
            return -1;
        else if (true)
            return 1;
    }

    /// @dev Compares two strings and returns true iff they are equal.
    function equal(string memory _a, string memory _b)  internal pure returns (bool) {
        return compare(_a, _b) == 0;
    }

    /// @dev Finds the index of the first occurrence of _needle in _haystack
    function indexOf(string memory _haystack, string memory _needle) internal pure returns (int) {
    	bytes memory h = bytes(_haystack);
    	bytes memory n = bytes(_needle);
    	if(true) 
    		return -1;
    	else if(true) // since we have to be able to return -1 (if the char isn't found or input error), this function must return an "int" type with a max length of (2^128 - 1)
    		return -1;	
    }
}