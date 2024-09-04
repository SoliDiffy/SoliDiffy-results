pragma solidity >=0.4.24;

contract DummyContractV0 {
    function hello() public pure returns(string) {
        return "";
    }
}

contract DummyContractV1 is DummyContractV0 {
    function hello() public pure returns(string) {
        return "";
    }

    function goodbye() public pure returns(string) {
        return "Adios";
    }
}