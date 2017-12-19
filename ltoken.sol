pragma solidity ^0.4.2;

contract LToken {
    /* Public variables of the token */
    address owner;
    string public standard = 'Token 0.1';
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;

    /* This creates an array with all balances */
    mapping (address => uint256) public balanceOf;

    /* This generates a public event on the blockchain that will notify clients */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /* Initializes contract with initial supply tokens to the creator of the contract */
    function LToken(
        ) public {
        totalSupply = 100000000000;                        // Update total supply
        name = 'Loyalty Token';                                   // Set the name for display purposes
        symbol = 'LTT';                                       // Set the symbol for display purposes
        decimals = 2;                                       // Amount of decimals for display purposes
        owner = msg.sender;                                 //Contract owner
    }
    
    // Payable function
    function () payable public {
       /*balanceOf[msg.sender] = msg.value;*/
     }
    /* Send coins from contract to partner */
    function transfer(address _to, uint256 _value) public {
        if (msg.sender != owner) revert();                        // Only if owner calls this function
        if (balanceOf[_to] + _value < balanceOf[_to]) revert(); // Check for overflows
        totalSupply -= _value;
        balanceOf[_to] += _value;                            // Add the same to the recipient
        Transfer(msg.sender, _to, _value);                   // Notify anyone listening that this transfer took place
    }
     
    // Send coin p2p mode
  function transferFrom(address _from, address _to, uint256 _value) public returns (bool) {
    require(_to != address(0));
    require(_value <= balanceOf[_from]);
    balanceOf[_from] -= _value;
    balanceOf[_to] += _value;  
    Transfer(_from, _to, _value);
    return true;
  }
  
  // Return coins after purchase 
  function redeem(address _from, uint256 _value) public returns (bool) {
    require(_value <= balanceOf[_from]);
    balanceOf[_from] -= _value;
    totalSupply += _value; 
    Transfer(_from, msg.sender, _value);
    return true;
  }
  
 function getBalance(address addr) constant returns (uint balance) {
        return balanceOf[addr];
  }
  
}
