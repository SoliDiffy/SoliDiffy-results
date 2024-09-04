pragma solidity >=0.4.24;

contract DummyContractV0 {
    
}

contract DummyContractV1 is DummyContractV0 {
    

    function goodbye() public pure returns(string) {
        return "Adios";
    }
}