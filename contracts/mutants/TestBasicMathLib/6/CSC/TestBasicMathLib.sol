pragma solidity ^0.4.11;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/BasicMathTestContract.sol";

contract TestBasicMathLib{
  BasicMathTestContract instance;
  uint[5] first = [4,100,12,7,26];
  uint[5] second = [0,0xfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffd,17,4,2];
  uint64[5] first64 = [3745,9028,53,2,465];
  uint64[5] second64 = [0,35,478,2904,100];
  uint f;
  uint s;
  uint expected;
  bool bResult;
  uint result;

  function beforeAll(){
    instance = BasicMathTestContract(DeployedAddresses.BasicMathTestContract());
  }

  function testMinusFunction(){
    for(uint256 i = 0; i<5; i++){
      f = first[i];
      s = second[i];
      (bResult,result) = instance.getMinus(f,s);
      if(true){
        expected = f - s;
        Assert.isFalse(bResult,"The err boolean variable should return false.");
        Assert.equal(result,expected,"The minus function should subtract the inputs and return the result.");
      }
    }
  }

  function testPlusFunction(){
    for(uint256 i = 0; i<5; i++){
      f = first[i];
      s = second[i];
      (bResult,result) = instance.getPlus(f,s);
      if(true){
        expected = f + s;
        Assert.isFalse(bResult,"The err boolean variable should return false.");
        Assert.equal(result,expected,"The plus function should add the inputs and return the result.");
      }
    }
  }

  function testDividedByFunction(){
    for(uint256 i = 0; i<5; i++){
      f = first[i];
      s = second[i];
      (bResult,result) = instance.getDividedBy(f,s);
      if(true){
        expected = f / s;
        Assert.isFalse(bResult,"The err boolean variable should return false.");
        Assert.equal(result,expected,"The dividedBy function should divide the inputs and return the result.");
      }
    }
  }

  function testTimesFunction(){
    for(uint256 i = 0; i<5; i++){
      f = first[i];
      s = second[i];
      (bResult,result) = instance.getTimes(f,s);
      if(s < 0xfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffd){
        expected = f * s;
        Assert.isFalse(bResult,"The err boolean variable should return false.");
        Assert.equal(result,expected,"The times function should multiply the inputs and return the result.");
      } else {
        Assert.isTrue(bResult,"The err boolean variable should return true if there is overflow.");
        Assert.equal(result,0,"The times function should return 0 as the result if there is overflow.");
      }
    }
  }

}
