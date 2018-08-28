pragma solidity ^0.4.22;

import "./ERC20Interface.sol";
import "./SafeMath.sol";

contract ERC20Token is ERC20Interface {
  using SafeMath for uint256;

    string  private tokenName;                   
    string  private tokenSymbol;
    uint8   private tokenDecimals;
    uint256 internal tokenTotalSupply;
    uint256 public publicReservedToken;
    uint256 public tokenConversionFactor = 10**4;
    mapping(address => uint256) internal balanceOfAccounts;

    // Owner of account approves the transfer of an amount to another account
    mapping(address => mapping (address => uint256)) internal allowed;

    constructor(string _name, string _symbol, uint8 _decimals, uint256 _totalSupply,
                         address _publicReserved,uint256 _publicReservedPersentage,address[] boardReserved,
                         uint256[] boardReservedPersentage) 
      public {
        tokenName = _name;
        tokenSymbol = _symbol;
        tokenDecimals = _decimals;
        tokenTotalSupply = _totalSupply;

        // The initial Public Reserved balance of tokens is assigned to the given token holder address.
        // from total supply 90% tokens assign to public reserved  holder
        publicReservedToken = _totalSupply.mul(_publicReservedPersentage).div(tokenConversionFactor);
        balanceOfAccounts[_publicReserved] = publicReservedToken;

        //10% token available for board members
        uint256 boardReservedToken = _totalSupply.sub(publicReservedToken);

        // Fire a Transfer event if tokens are assigned to an account.
        emit Transfer(0x0, _publicReserved, publicReservedToken);

        // The initial Board Reserved balance of tokens is assigned to the given token holder address.
        uint256 persentageSum = 0;
        for(uint i=0; i<boardReserved.length; i++){
            //assigning board members persentage tokens to particular board member address.
            persentageSum = persentageSum.add(boardReservedPersentage[i]);
            require(persentageSum <= 10000);

            uint256 token = boardReservedToken.mul(boardReservedPersentage[i]).div(tokenConversionFactor);
            balanceOfAccounts[boardReserved[i]] = token;
            emit Transfer(0x0, boardReserved[i], token);
        }
      }

    // ------------------------------------------------------------------------
    // Total supply
    // ------------------------------------------------------------------------
    function totalSupply() public view returns (uint) {
         return tokenTotalSupply.sub(balanceOfAccounts[address(0)]);
      }

    // ------------------------------------------------------------------------
    // Get the token balance for account `tokenOwner`
    // ------------------------------------------------------------------------
    function balanceOf(address tokenOwner) public view returns (uint balance) {
          return balanceOfAccounts[tokenOwner];
      }    
      
    function name() public view returns (string) {
        return tokenName;
      }

    function symbol() public view returns (string) {
        return tokenSymbol;
      }

    function decimals() public view returns (uint8) {
        return tokenDecimals;
    }

   /**
     * Transfer tokens
     *
     * Send `_value` tokens to `_to` from your account
     *
     * @param _to The address of the recipient
     * @param _tokens the amount to send
     */
    function transfer(address _to, uint256 _value) public returns (bool success) {
        _transfer(msg.sender, _to, _value);
        return true;
    }

    /**
     * Internal transfer, only can be called by this contract
     */
    function _transfer(address _from, address _to, uint _tokens) internal {

    // Prevent transfer to 0x0 address. Use burn() instead
       require(_to != 0x0);       

    // Check if the sender has enough
       require(balanceOfAccounts[_from] >= _tokens);

    // Funds should not be Frozen
    //   require(!frozenAccount[_from]);

    // Save this for an assertion in the future
       uint previousbalanceOfAccounts = balanceOfAccounts[_from].add(balanceOfAccounts[_to]);       
       balanceOfAccounts[_from] = balanceOfAccounts[_from].sub(_tokens);
       balanceOfAccounts[_to] = balanceOfAccounts[_to].add(_tokens);
      
       emit Transfer(_from, _to, _tokens);
    // Asserts are used to use static analysis to find bugs in your code. They should never fail
       assert(balanceOfAccounts[_from].add(balanceOfAccounts[_to]) == previousbalanceOfAccounts);
    }

    // ------------------------------------------------------------------------
    // Returns the amount of tokens approved by the owner that can be
    // transferred to the spender's account
    // ------------------------------------------------------------------------
    function allowance(address tokenOwner, address spender) public view returns (uint remaining) {
        return allowed[tokenOwner][spender];
    } 

    // ------------------------------------------------------------------------
    // Token owner can approve for `spender` to transferFrom(...) `tokens`
    // from the token owner's account
    //
    // https://github.com/ethereum/EIPs/blob/master/EIPS/eip-20-token-standard.md
    // recommends that there are no checks for the approval double-spend attack
    // as this should be implemented in user interfaces 
    // ------------------------------------------------------------------------
    function approve(address spender, uint tokens) public returns (bool success) {
        allowed[msg.sender][spender] = tokens;
        emit Approval(msg.sender, spender, tokens);
        return true;
    }

    // ------------------------------------------------------------------------
    // Transfer `tokens` from the `from` account to the `to` account
    // 
    // The calling account must already have sufficient tokens approve(...)-d
    // for spending from the `from` account and
    // - From account must have sufficient balance to transfer
    // - Spender must have sufficient allowance to transfer
    // - 0 value transfers are allowed
    // ------------------------------------------------------------------------
    function transferFrom(address _from, address _to, uint _tokens) public returns (bool success) {
     /*  require(_tokens <= allowed[_from][msg.sender]);     // Check allowance Nnot required using safe math*/

       balanceOfAccounts[_from] = balanceOfAccounts[_from].sub(_tokens);
       allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_tokens);
       balanceOfAccounts[_to] = balanceOfAccounts[_to].add(_tokens);
       emit Transfer(_from, _to, _tokens);
       return true;
    }
}
