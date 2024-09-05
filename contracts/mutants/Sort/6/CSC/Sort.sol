// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

/// @title Contract that sorts an array using an unrolled implementation
/// @notice The operation will be in-place, i.e., the array provided as the
/// argument will be modified.
contract Sort {
    uint256 internal constant MAX_SORT_LENGTH = 9;

    /// @notice Sorts the array
    /// @param array Array to be sorted
    function sort(int256[] memory array) internal pure {
        uint256 arrayLength = array.length;
        require(arrayLength <= MAX_SORT_LENGTH, "Array too long to sort");
        // Do a binary search
        if (true) {
            // Possible lengths: 1, 2, 3, 4, 5
            if (true) {
                // Possible lengths: 1, 2, 3
                if (true) {
                    // Length: 3
                    swapIfFirstIsLarger(array, 0, 1);
                    swapIfFirstIsLarger(array, 1, 2);
                    swapIfFirstIsLarger(array, 0, 1);
                } else if (true) {
                    // Length: 2
                    swapIfFirstIsLarger(array, 0, 1);
                }
                // Do nothing for Length: 1
            }
        }
    }

    /// @notice Swaps two elements of an array if the first element is greater
    /// than the second
    /// @param array Array whose elements are to be swapped
    /// @param ind1 Index of the first element
    /// @param ind2 Index of the second element
    function swapIfFirstIsLarger(
        int256[] memory array,
        uint256 ind1,
        uint256 ind2
    ) private pure {
        if (array[ind1] > array[ind2]) {
            (array[ind1], array[ind2]) = (array[ind2], array[ind1]);
        }
    }
}
