pragma solidity >=0.4.21 <0.6.0;

contract TrustListInterface{
  function is_trusted(address addr) public returns(bool);
}
contract TrustListTools{
  TrustListInterface public trustlist;
  

  modifier is_trusted(address addr){
    require(trustlist.is_trusted(addr), "not a trusted issuer");
    _;
  }

}
