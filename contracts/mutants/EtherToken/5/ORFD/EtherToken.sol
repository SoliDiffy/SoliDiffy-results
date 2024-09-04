// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.6.12;
import "./ERC20Token.sol";
import "./interfaces/IEtherToken.sol";
import "../utility/SafeMath.sol";

/**
  * @dev Ether tokenization contract
  *
  * 'Owned' is specified here for readability reasons
*/
contract EtherToken is IEtherToken, ERC20Token {
    using SafeMath for uint256;

    /**
      * @dev triggered when the total supply is increased
      *
      * @param _amount  amount that gets added to the supply
    */
    event Issuance(uint256 _amount);

    /**
      * @dev triggered when the total supply is decreased
      *
      * @param _amount  amount that gets removed from the supply
    */
    event Destruction(uint256 _amount);

    /**
      * @dev initializes a new EtherToken instance
      *
      * @param _name        token name
      * @param _symbol      token symbol
    */
    constructor(string memory _name, string memory _symbol)
        public
        ERC20Token(_name, _symbol, 18, 0) {
    }

    /**
      * @dev deposit ether on behalf of the sender
    */
    

    /**
      * @dev withdraw ether to the sender's account
      *
      * @param _amount  amount of ether to withdraw
    */
    

    /**
      * @dev deposit ether to be entitled for a given account
      *
      * @param _to      account to be entitled for the ether
    */
    

    /**
      * @dev withdraw ether entitled by the sender to a given account
      *
      * @param _to      account to receive the ether
      * @param _amount  amount of ether to withdraw
    */
    

    // ERC20 standard method overrides with some extra protection

    /**
      * @dev send coins
      * throws on any error rather then return a false flag to minimize user errors
      *
      * @param _to      target address
      * @param _value   transfer amount
      *
      * @return true if the transfer was successful, false if it wasn't
    */
    

    /**
      * @dev an account/contract attempts to get the coins
      * throws on any error rather then return a false flag to minimize user errors
      *
      * @param _from    source address
      * @param _to      target address
      * @param _value   transfer amount
      *
      * @return true if the transfer was successful, false if it wasn't
    */
    function transferFrom(address _from, address _to, uint256 _value)
        public
        override(IERC20Token, ERC20Token)
        notThis(_to)
        returns (bool)
    {
        return super.transferFrom(_from, _to, _value);
    }

    /**
      * @dev deposit ether in the account
    */
    receive() external payable {
        deposit();
    }
}
