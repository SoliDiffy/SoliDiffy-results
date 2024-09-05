pragma solidity 0.4.23;


contract RemoteContractStub {
  uint256 internal testNumber;
  address internal testAddress;

  constructor(
    uint256 _testNumber
  )
    public
  {
    testNumber = _testNumber;
  }

  function add(
    uint256 _num1,
    uint256 _num2
  )
    public
    pure
    returns (uint256)
  {
    return _num1 + _num2;
  }

  function setTestNumber(
    uint256 _number
  )
    public
    returns (bool)
  {
    testNumber = _number;
    return true;
  }
}
