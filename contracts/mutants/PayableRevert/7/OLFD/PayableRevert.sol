// SPDX-License-Identifier: AGPL-3.0

pragma solidity ^0.6.0;

interface IWithdrawalDelayer {
    

    

    

    
}

contract PayableRevert {
    bool public paymentEnable = true;

    function disablePayment() public {
        paymentEnable = false;
    }

    function enablePayment() public {
        paymentEnable = true;
    }

    fallback() external payable {
        require(paymentEnable, "Not payable");
    }

    receive() external payable {
        require(paymentEnable, "Not payable");
    }

    

    

    

    function setWhiteHackGroupAddress(
        address withdrawalDelayerAddress,
        address payable newAddress
    ) public {
        IWithdrawalDelayer(withdrawalDelayerAddress).setWhiteHackGroupAddress(
            newAddress
        );
    }
}
