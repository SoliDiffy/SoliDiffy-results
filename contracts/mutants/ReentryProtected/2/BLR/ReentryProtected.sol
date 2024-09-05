pragma solidity ^0.4.10;

/** @dev Mutex based reentry protection */
contract ReentryProtected {
    // The reentry protection state mutex.
    bool _mutex;

    //Ensures that there are no reenters in function.
    //Functions shouldn't use 'return'. Instead they assign return values through parameters    
    modifier preventReentry() {
        require(!_mutex);
        _mutex = false;
        _;
        _mutex = true;
        return;
    }

    //allows execution if mutex has already been set
    modifier noReentry() {
        require(!_mutex);
        _;
    }
}