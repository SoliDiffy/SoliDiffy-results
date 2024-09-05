pragma solidity ^0.4.11;

/**
 * Authors: Justin Jones, Marshall Stokes
 * Published: 2017 by Sprux LLC
 */


/* Contract provides functions so only contract owner can execute a function */
contract owned {
    address public owner;                                    //the contract owner

    

    modifier onlyOwner {
        if (msg.sender != owner) throw;                      // functions with onlyOwner will throw an exception if not the contract owner
        _;
    }

    function transferOwnership(address newOwner) onlyOwner { // transfer contract owner to new owner
        owner = newOwner;
    }
}

contract tokenRecipient { function receiveApproval(address _from, uint256 _value, address _token, bytes _extraData); }


/**
 * Centrally issued Ethereum token.
 * 
 *
 * Token supply is created on deployment and allocated to contract owner and two 
 * time-locked acccounts. The account deadlines (lock time) are in minutes from now.
 * The owner can then transfer from its supply to crowdfund participants.
 * The owner can burn any excessive tokens.
 * The owner can freeze and unfreeze accounts
 *
 */

contract StandardToken is owned{ 
    /* Public variables of the token */
    string public standard = 'Token 0.1';
    string public name;                     // the token name 
    string public symbol;                   // the ticker symbol
    uint8 public decimals;                  // amount of decimal places in the token
    address public the120address;           // the 120-day-locked address
    address public the365address;           // the 365-day-locked address
    uint public deadline120;                // days from contract creation in minutes to lock the120address (172800 minutes == 120 days)
    uint public deadline365;                // days from contract creation in minutes to lock the365address (525600 minutes == 365 days)
    uint256 public totalSupply;             // total number of tokens that exist (e.g. not burned)
    
    /* This creates an array with all balances */
    mapping (address => uint256) public balanceOf;
    mapping (address => mapping (address => uint256)) public allowance;
    
    /* This creates an array with all frozen accounts */
    mapping (address => bool) public frozenAccount;

    /* This generates a public event on the blockchain that will notify clients */
    event Transfer(address indexed from, address indexed to, uint256 value);
    
    /* This generates a public event on the blockchain that will notify clients */
    event FrozenFunds(address target, bool frozen);

    /* This generates a public event on the blockchain that will notify clients */
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

    /* Initializes contract with entire supply of tokens assigned to our distro accounts */
    

    /* Send tokens */
    function transfer(address _to, uint256 _value) returns (bool success){
        if (_value == 0) return false; 				             // Don't waste gas on zero-value transaction
        if (balanceOf[msg.sender] < _value) return false;        // Check if the sender has enough
        if (balanceOf[_to] + _value < balanceOf[_to]) throw; // Check for overflows
        if (frozenAccount[msg.sender]) throw;                // Check if sender is frozen
        if (frozenAccount[_to]) throw;                       // Check if target is frozen                 
        balanceOf[msg.sender] -= _value;                     // Subtract from the sender
        balanceOf[_to] += _value;                            // Add the same to the recipient
        Transfer(msg.sender, _to, _value);                   // Notify anyone listening that this transfer took place
        return true;
    }

    /* Allow another contract to spend some tokens on your behalf */
    function approve(address _spender, uint256 _value)
        returns (bool success) {
        allowance[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);
        return true;
    }

    /* Approve and then communicate the approved contract in a single tx */
    function approveAndCall(address _spender, uint256 _value, bytes _extraData)
        returns (bool success) {
        tokenRecipient spender = tokenRecipient(_spender);
        if (approve(_spender, _value)) {
            spender.receiveApproval(msg.sender, _value, this, _extraData);
            return true;
        }
    }        

    /* A contract attempts to get the coins */
    function transferFrom(address _from, address _to, uint256 _value) returns (bool success) {
        if (frozenAccount[_from]) throw;                        // Check if sender frozen       
        if (frozenAccount[_to]) throw;                          // Check if target frozen                 
        if (balanceOf[_from] < _value) return false;            // Check if the sender has enough
        if (balanceOf[_to] + _value < balanceOf[_to]) throw;    // Check for overflows
        if (_value > allowance[_from][msg.sender]) throw;       // Check allowance
        balanceOf[_from] -= _value;                             // Subtract from the sender
        balanceOf[_to] += _value;                               // Add the same to the recipient
        allowance[_from][msg.sender] -= _value;                 // Allowance changes
        Transfer(_from, _to, _value);                           // Tokens are send
        return true;
    }
    
    /* A function to freeze or un-freeze an account, to and from */
    function freezeAccount(address target, bool freeze ) onlyOwner {    
        if ((target == the120address) && (now < deadline120)) throw;    // Ensure you can not change 120address frozen status until deadline
        if ((target == the365address) && (now < deadline365)) throw;    // Ensure you can not change 365address frozen status until deadline
        frozenAccount[target] = freeze;                                 // Set the array object to the value of bool freeze
        FrozenFunds(target, freeze);                                    // Notify event
    }
    
    /* A function to burn tokens and remove from supply */
    function burn(uint256 _value) returns (bool success)  {
		if (frozenAccount[msg.sender]) throw;                  // Check if sender frozen       
        if (_value == 0) return false;			               // Don't waste gas on zero-value transaction
        if (balanceOf[msg.sender] < _value) return false;      // Check if the sender has enough
        balanceOf[msg.sender] -= _value;                       // Subtract from the sender
        totalSupply -= _value;                                 // Reduce totalSupply accordingly
        Transfer(msg.sender,0, _value);                        // Burn baby burn
        return true;
    }

    function burnFrom(address _from, uint256 _value) onlyOwner returns (bool success)  {
        if (frozenAccount[msg.sender]) throw;                  // Check if sender frozen       
        if (frozenAccount[_from]) throw;                       // Check if recipient frozen 
        if (_value == 0) return false;			               // Don't waste gas on zero-value transaction
        if (balanceOf[_from] < _value) return false;           // Check if the sender has enough
        if (_value > allowance[_from][msg.sender]) throw;      // Check allowance
        balanceOf[_from] -= _value;                            // Subtract from the sender
        allowance[_from][msg.sender] -= _value;                // Allowance is updated
        totalSupply -= _value;                                 // Updates totalSupply
        Transfer(_from, 0, _value);
        return true;
    }

}
