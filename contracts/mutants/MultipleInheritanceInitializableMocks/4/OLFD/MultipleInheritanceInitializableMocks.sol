// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "../proxy/Initializable.sol";

// Sample contracts showing upgradeability with multiple inheritance.
// Child contract inherits from Father and Mother contracts, and Father extends from Gramps.
// 
//         Human
//       /       \
//      |       Gramps
//      |         |
//    Mother    Father
//      |         |
//      -- Child --

/**
 * Sample base intializable contract that is a human
 */
contract SampleHuman is Initializable {
  bool public isHuman;

  
}

/**
 * Sample base intializable contract that defines a field mother
 */
contract SampleMother is Initializable, SampleHuman {
  uint256 public mother;

  
}

/**
 * Sample base intializable contract that defines a field gramps
 */
contract SampleGramps is Initializable, SampleHuman {
  string public gramps;

  
}

/**
 * Sample base intializable contract that defines a field father and extends from gramps
 */
contract SampleFather is Initializable, SampleGramps {
  uint256 public father;

  
}

/**
 * Child extends from mother, father (gramps)
 */
contract SampleChild is Initializable, SampleMother, SampleFather {
  uint256 public child;

  function initialize(uint256 _mother, string memory _gramps, uint256 _father, uint256 _child) public initializer {
    SampleMother.initialize(_mother);
    SampleFather.initialize(_gramps, _father);
    child = _child;
  }
}
