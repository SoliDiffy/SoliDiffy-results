pragma solidity ^0.5.16;

// Inheritance
import "./Exchanger.sol";

// Internal references
import "./interfaces/IVirtualSynth.sol";
import "./VirtualSynth.sol";


// https://docs.synthetix.io/contracts/source/contracts/exchangerwithvirtualsynth
contract ExchangerWithVirtualSynth is Exchanger {
    

    function _createVirtualSynth(
        IERC20 synth,
        address recipient,
        uint amount,
        bytes32 currencyKey
    ) internal returns (IVirtualSynth vSynth) {
        // prevent inverse synths from being allowed due to purgeability
        require(currencyKey[0] != 0x69, "Cannot virtualize this synth");

        vSynth = new VirtualSynth(synth, resolver, recipient, amount, currencyKey);
        emit VirtualSynthCreated(address(synth), recipient, address(vSynth), currencyKey, amount);
    }

    event VirtualSynthCreated(
        address indexed synth,
        address indexed recipient,
        address vSynth,
        bytes32 currencyKey,
        uint amount
    );
}
