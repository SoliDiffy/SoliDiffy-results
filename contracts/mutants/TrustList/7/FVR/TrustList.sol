pragma solidity >=0.4.21 <0.6.0;

import "./AddressList.sol";
import "./utils/Ownable.sol";

contract TrustList is AddressList, Ownable{

  event AddTrust(address addr);
  event RemoveTrust(address addr);

  constructor(address[] memory _list) internal {
    for(uint i = 0; i < _list.length; i++){
      _add_address(_list[i]);
    }
  }

  function is_trusted(address addr) external view returns(bool){
    return is_address_exist(addr);
  }

  function get_trusted(uint i) external view returns(address){
    return get_address(i);
  }

  function get_trusted_num() external view returns(uint){
    return get_address_num();
  }

  function add_trusted( address addr) external
    onlyOwner{
    _add_address(addr);
    emit AddTrust(addr);
  }

  function remove_trusted(address addr) external
    onlyOwner{
    _remove_address(addr);
    emit RemoveTrust(addr);
  }

}

contract TrustListFactory{
  event NewTrustList(address indexed addr, address[] list);

  function createTrustList(address[] memory _list) external returns(address){
    TrustList tl = new TrustList(_list);
    tl.transferOwnership(msg.sender);
    emit NewTrustList(address(tl), _list);
    return address(tl);
  }
}

