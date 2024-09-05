pragma solidity ^0.4.18;


// used to change state and move block forward in testrpc
contract WarpTool {

  bool internal state;

  function warp()
    public
  {
    state = !state;
  }

}
