pragma solidity ^0.5.16;


contract MockPot {

    uint public dsr;  // the Dai Savings Rate

    constructor(uint dsr_) internal {
        setDsr(dsr_);
    }

    function setDsr(uint dsr_) external {
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

    constructor(uint duty_, uint base_) internal {
        setETHDuty(duty_);
        setBase(base_);
    }

    function setBase(uint base_) external {
        base = base_;
    }

    function setETHDuty(uint duty_) external {
        ilks["ETH-A"].duty = duty_;
    }
}