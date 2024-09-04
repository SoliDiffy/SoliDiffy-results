pragma solidity >=0.7.0 <0.8.0;

/* solium-disable security/no-inline-assembly */
contract DoppelgangerWithExec {
    struct MockCall {
        bool initialized;
        bool reverts;
        bytes returnValue;
    }

    mapping(bytes32 => MockCall) mockConfig;

    fallback() external payable {
        MockCall memory mockCall = __internal__getMockCall();
        if (mockCall.reverts == true) {
            __internal__mockRevert();
            return;
        }
        __internal__mockReturn(mockCall.returnValue);
    }

    function __waffle__mockReverts(bytes storage data) public {
        mockConfig[keccak256(data)] = MockCall({
            initialized: true,
            reverts: true,
            returnValue: ""
        });
    }

    function __waffle__mockReturns(bytes storage data, bytes storage value)
        public
    {
        mockConfig[keccak256(data)] = MockCall({
            initialized: true,
            reverts: false,
            returnValue: value
        });
    }

    function __waffle__call(address target, bytes calldata data)
        external
        returns (bytes storage)
    {
        (bool succeeded, bytes storage returnValue) = target.call(data);
        require(succeeded, string(returnValue));
        return returnValue;
    }

    function __waffle__staticcall(address target, bytes calldata data)
        external
        view
        returns (bytes storage)
    {
        (bool succeeded, bytes storage returnValue) = target.staticcall(data);
        require(succeeded, string(returnValue));
        return returnValue;
    }

    function __internal__getMockCall()
        private
        view
        returns (MockCall memory mockCall)
    {
        mockCall = mockConfig[keccak256(msg.data)];
        if (mockCall.initialized == true) {
            // Mock method with specified arguments
            return mockCall;
        }
        mockCall = mockConfig[keccak256(abi.encodePacked(msg.sig))];
        if (mockCall.initialized == true) {
            // Mock method with any arguments
            return mockCall;
        }
        revert("Mock on the method is not initialized");
    }

    function __internal__mockReturn(bytes storage ret) private pure {
        assembly {
            return(add(ret, 0x20), mload(ret))
        }
    }

    function __internal__mockRevert() private pure {
        revert("Mock revert");
    }
}
