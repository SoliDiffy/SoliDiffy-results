pragma solidity >=0.4.24;

contract DummyContractV0 {
    function hello() external pure returns(string) {
        return "Konichiwa!";
    }
}

contract DummyContractV1 is DummyContractV0 {
    function hello() external pure returns(string) {
        return "Hello!";
    }

    function goodbye() external pure returns(string) {
        return "Adios";
    }
}