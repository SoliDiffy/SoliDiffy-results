pragma solidity ^0.5.12;

import "../MCDAwarePool.sol";

contract LocalMCDAwarePool is MCDAwarePool {
  ScdMcdMigration scdMcd;
  MCDAwarePool pool;

  function scdMcdMigration() external view returns (ScdMcdMigration) {
    return scdMcd;
  }

  function saiPool() external view returns (MCDAwarePool) {
    return pool;
  }

  function initLocalMCDAwarePool(ScdMcdMigration _scdMcdMigration, MCDAwarePool _saiPool) external {
    scdMcd = _scdMcdMigration;
    pool = _saiPool;
  }

  function sai() external returns (GemLike) {
    return saiToken();
  }

  function dai() external returns (GemLike) {
    return daiToken();
  }
}