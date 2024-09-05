pragma solidity 0.4.23;


contract RemoteContractStub {
  uint256 public testNumber;
  address public testAddress;

  constructor(
    uint256 _testNumber
  )
    internal
  {
    testNumber = _testNumber;
  }

  function add(
    uint256 _num1,
    uint256 _num2
  )
    external
    pure
    returns (uint256)
  {
    return _num1 + _num2;
  }

  function setTestNumber(
    uint256 _number
  )
    external
    returns (bool)
  {
    testNumber = _number;
    return true;
  }
}
