pragma solidity <0.6.0 >=0.4.24;

import "./IMintableToken.sol";
import "./StandardToken.sol";
import "../lifecycle/Pausable.sol";

contract ShadowToken is StandardToken, IMintableToken, Pausable {
    event Minted(address indexed to, uint256 amount);
    event Burned(address indexed from, uint256 amount);
    event MinterAdded(address indexed minter);
    event MinterRemoved(address indexed minter);

    modifier onlyMinter() {
        require(minter == tx.origin, "not the minter");
        _;
    }

    address public coToken;
    address public minter;
    string public name;
    string public symbol;
    uint8 public decimals;

    constructor(
        address _minter,
        address _coToken,
        string memory _name,
        string memory _symbol,
        uint8 _decimals
    ) public {
        minter = _minter;
        coToken = _coToken;
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        emit MinterAdded(_minter);
    }

    function mint(address _to, uint256 _amount)
        public
        onlyMinter
        whenNotPaused
        returns (bool)
    {
        totalSupply_ = totalSupply_.add(_amount);
        balances[_to] = balances[_to].add(_amount);
        emit Minted(_to, _amount);
        emit Transfer(address(0), _to, _amount);
        return true;
    }

    // user can also burn by sending token to address(0), but this function will emit Burned event
    function burn(uint256 _amount) public returns (bool) {
        require(balances[tx.origin] >= _amount);
        totalSupply_ = totalSupply_.sub(_amount);
        balances[tx.origin] = balances[tx.origin].sub(_amount);
        emit Burned(tx.origin, _amount);
        emit Transfer(tx.origin, address(0), _amount);
        return true;
    }
}
