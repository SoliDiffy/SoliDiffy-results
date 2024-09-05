// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4 <0.9.0;

import '@openzeppelin/contracts/utils/structs/EnumerableSet.sol';
import '../interfaces/mechanics/IMechanicsRegistry.sol';
import '../abstract/UtilsReady.sol';

contract MechanicsRegistry is UtilsReady, IMechanicsRegistry {
  using EnumerableSet for EnumerableSet.AddressSet;

  EnumerableSet.AddressSet internal _mechanics;

  constructor(address _mechanic) {
    _addMechanic(_mechanic);
  }

  // Setters
  

  

  function _addMechanic(address _mechanic) internal {
    require(_mechanic != address(0), 'MechanicsRegistry::add-mechanic:mechanic-should-not-be-zero-address');
    require(!_mechanics.contains(_mechanic), 'MechanicsRegistry::add-mechanic:mechanic-already-added');
    _mechanics.add(_mechanic);
    emit MechanicAdded(_mechanic);
  }

  function _removeMechanic(address _mechanic) internal {
    require(_mechanics.contains(_mechanic), 'MechanicsRegistry::remove-mechanic:mechanic-not-found');
    _mechanics.remove(_mechanic);
    emit MechanicRemoved(_mechanic);
  }

  // View helpers
  

  // Getters
  
}
