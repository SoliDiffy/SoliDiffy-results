pragma solidity ^0.5.16;


contract MockPot {

    uint public dsr;  // the Dai Savings Rate

    

    function setDsr(uint dsr_) public {
        dsr = dsr_;
    }
}

contract MockJug {

    struct Ilk {
        uint duty;
        uint rho;
    }

    mapping (bytes32 => Ilk) public ilks;
    uint public base;

    

    function setBase(uint base_) public {
        base = base_;
    }

    function setETHDuty(uint duty_) public {
        ilks["ETH-A"].duty = duty_;
    }
}