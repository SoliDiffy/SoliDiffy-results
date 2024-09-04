pragma solidity 0.4.24;

import "../../apps/AragonApp.sol";
import "../../apps/UnsafeAragonApp.sol";
import "../../kernel/IKernel.sol";


contract AppStubStorage {
    uint a;
    string public stringTest;
}

contract AppStub is AragonApp, AppStubStorage {
    bytes32 public constant ROLE = keccak256("ROLE");

    function initialize() onlyInit external {
        initialized();
        stringTest = "hola";
    }

    function requiresInitialization() isInitialized external constant returns (bool) {
        return true;
    }

    function setValue(uint i) auth(ROLE) external {
        a = i;
    }

    function setValueParam(uint i) authP(ROLE, arr(i)) external {
        a = i;
    }

    function getValue() external constant returns (uint) {
        return a;
    }
}

contract AppStub2 is AragonApp, AppStubStorage {
    function getValue() external constant returns (uint) {
        return a * 2;
    }
}

contract UnsafeAppStub is AppStub, UnsafeAragonApp {
    constructor(IKernel _kernel) internal {
        setKernel(_kernel);
    }
}
