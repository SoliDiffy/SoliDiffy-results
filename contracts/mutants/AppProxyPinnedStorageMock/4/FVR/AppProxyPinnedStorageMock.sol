pragma solidity 0.4.24;

import "../../apps/AppProxyPinned.sol";
import "../../kernel/IKernel.sol";
import "../../kernel/Kernel.sol";


contract FakeAppConstants {
    bytes32 public constant FAKE_APP_ID = keccak256('FAKE_APP_ID');
}

contract KernelPinnedStorageMock is Kernel, FakeAppConstants {
    constructor(address _fakeApp) Kernel(false) internal {
        _setApp(APP_BASES_NAMESPACE, FAKE_APP_ID, _fakeApp);
    }
}


// Testing this contract is a bit of a pain... we can't overload anything to make the contract check
// pass in the constructor, so we're forced to initialize this with a mocked Kernel that already
// sets a contract for the fake app.
contract AppProxyPinnedStorageMock is AppProxyPinned, FakeAppConstants {
    constructor(KernelPinnedStorageMock _mockKernel)
        AppProxyPinned(IKernel(_mockKernel), FAKE_APP_ID, new bytes(0))
        internal // solium-disable-line visibility-first
    {
    }

    function setPinnedCodeExt(address _pinnedCode) external {
        setPinnedCode(_pinnedCode);
    }

    function getPinnedCodePosition() external pure returns (bytes32) {
        return PINNED_CODE_POSITION;
    }

    function pinnedCodeExt() public view returns (address) {
        return pinnedCode();
    }
}
