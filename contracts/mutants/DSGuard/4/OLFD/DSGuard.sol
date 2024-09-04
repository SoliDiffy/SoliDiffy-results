// SPDX-License-Identifier: MIT

pragma solidity ^0.7.0;

abstract contract DSGuard {
    function canCall(
        address src_,
        address dst_,
        bytes4 sig
    ) public view virtual returns (bool);

    

    

    

    
}

abstract contract DSGuardFactory {
    function newGuard() public virtual returns (DSGuard guard);
}
