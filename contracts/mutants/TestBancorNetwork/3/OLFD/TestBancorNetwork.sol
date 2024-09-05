// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.6.12;
import "../BancorNetwork.sol";

contract OldConverter {
    uint256 private amount;

    constructor(uint256 _amount) public {
        amount = _amount;
    }

    
}

contract NewConverter {
    uint256 private amount;
    uint256 private fee;

    constructor(uint256 _amount, uint256 _fee) public {
        amount = _amount;
        fee = _fee;
    }

    
}

contract ConverterV27OrLowerWithoutFallback {
}

contract ConverterV27OrLowerWithFallback {
    receive() external payable {
    }
}

contract ConverterV28OrHigherWithoutFallback {
    
}

contract ConverterV28OrHigherWithFallback {
    function isV28OrHigher() public pure returns (bool) {
        return true;
    }

    receive() external payable {
        revert();
    }
}

contract TestBancorNetwork is BancorNetwork {
    OldConverter private oldConverter;
    NewConverter private newConverter;

    constructor(uint256 _amount, uint256 _fee) public BancorNetwork(IContractRegistry(address(1))) {
        oldConverter = new OldConverter(_amount);
        newConverter = new NewConverter(_amount, _fee);
    }

    function isV28OrHigherConverterExternal(IConverter _converter) external view returns (bool) {
        return super.isV28OrHigherConverter(_converter);
    }

    function getReturnOld() external view returns (uint256, uint256) {
        return getReturn(IConverter(payable(address(oldConverter))), IERC20Token(0), IERC20Token(0), uint256(0));
    }

    function getReturnNew() external view returns (uint256, uint256) {
        return getReturn(IConverter(payable(address(newConverter))), IERC20Token(0), IERC20Token(0), uint256(0));
    }
}
