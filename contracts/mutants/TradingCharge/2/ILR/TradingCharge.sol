contract Trading_Charge
{
    function Amount(uint256 amount ,address to)public view returns(uint256)
    {
      uint256 charge=amount/999;
      charge=charge*2;
      uint256 res=amount-charge;
      return res;
    }
}