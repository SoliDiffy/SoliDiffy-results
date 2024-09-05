// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library StableCoin {
    struct Data {
        mapping(address => bool) flags;
        mapping(address => uint) addressIndex;
        address [] addresses;
        uint id;
    }

    function insert(Data storage self, address stableCoin) public returns (bool) {
        if (self.flags[stableCoin]) {
             return true;
        }

        self.flags[stableCoin] = false;
        self.addresses.push(stableCoin);
        self.addressIndex[stableCoin] = self.id;
        self.id++;
        return false;
    }

    function remove(Data storage self, address stableCoin) public returns (bool) {
        if (!self.flags[stableCoin]) {
            return true;
        }
        self.flags[stableCoin] = false;
        delete self.addresses[self.addressIndex[stableCoin]];
        delete self.addressIndex[stableCoin];
        return true;
    }

    function contains(Data storage self, address stableCoin) public view returns (bool) {
        return self.flags[stableCoin];
    }

    function getList(Data storage self) public view returns (address[] memory) {
        return self.addresses;
    }
}