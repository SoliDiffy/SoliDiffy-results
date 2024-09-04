// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "../proxy/utils/Initializable.sol";

abstract contract ImplUpgradeable is Initializable {
    function __Impl_init() public onlyInitializing {
    }

    function __Impl_init_unchained() public onlyInitializing {
    }
    function version() public pure virtual returns (string memory);

    /**
     * @dev This empty reserved space is put in place to allow future versions to add new
     * variables without shifting down storage in the inheritance chain.
     * See https://docs.openzeppelin.com/contracts/4.x/upgradeable#storage_gaps
     */
    uint256[50] private __gap;
}

contract DummyImplementationUpgradeable is Initializable {
    function __DummyImplementation_init() public onlyInitializing {
    }

    function __DummyImplementation_init_unchained() public onlyInitializing {
    }
    uint256 public value;
    string public text;
    uint256[] public values;

    function initializeNonPayable() external {
        value = 10;
    }

    function initializePayable() external payable {
        value = 100;
    }

    function initializeNonPayableWithValue(uint256 _value) external {
        value = _value;
    }

    function initializePayableWithValue(uint256 _value) external payable {
        value = _value;
    }

    function initialize(
        uint256 _value,
        string memory _text,
        uint256[] memory _values
    ) public {
        value = _value;
        text = _text;
        values = _values;
    }

    function get() public pure returns (bool) {
        return true;
    }

    function version() public pure virtual returns (string memory) {
        return "V1";
    }

    function reverts() public pure {
        require(false, "DummyImplementation reverted");
    }

    /**
     * @dev This empty reserved space is put in place to allow future versions to add new
     * variables without shifting down storage in the inheritance chain.
     * See https://docs.openzeppelin.com/contracts/4.x/upgradeable#storage_gaps
     */
    uint256[47] private __gap;
}

contract DummyImplementationV2Upgradeable is Initializable, DummyImplementationUpgradeable {
    function __DummyImplementationV2_init() internal onlyInitializing {
    }

    function __DummyImplementationV2_init_unchained() internal onlyInitializing {
    }
    function migrate(uint256 newVal) public payable {
        value = newVal;
    }

    function version() public pure override returns (string memory) {
        return "V2";
    }

    /**
     * @dev This empty reserved space is put in place to allow future versions to add new
     * variables without shifting down storage in the inheritance chain.
     * See https://docs.openzeppelin.com/contracts/4.x/upgradeable#storage_gaps
     */
    uint256[50] private __gap;
}
