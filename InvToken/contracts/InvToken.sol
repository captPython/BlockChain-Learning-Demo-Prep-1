pragma solidity ^0.4.22;

contract InvToken {
  // Declare the metadata for the coin
  string public constant name = "MLM Investment Token";
  string public constant symbol = "INV";
  uint8  public constant decimals = 0;

  /// @dev 40% dividends for token purchase
    uint8 constant internal entryFee_ = 40;

  /// @dev 10% dividends for existing memeber
    uint8 constant internal dividendFee_ = 10;

  // Maintain the total supply
    uint256 internal tokenSupply_;

 // amount of shares for each address (scaled number)
    mapping(address => uint256) internal tokenBalanceLedger_;
    mapping(address => uint256) internal referralBalance_;

    // Constructor sets the initial supply as total available
    constructor(uint256 initSupply) {
      tokenSupply_ = initSupply;
      // Set the sender as the owner of all the initial set of tokens
      // Declare the balances mapping
      tokenBalanceLedger_[msg.sender] = tokenSupply_;
  }

  /*=======================================
    =            PUBLIC FUNCTIONS           =
    =======================================*/

   // transfer function
   function transfer(address _to, uint256 _value) public returns (bool success){
     if(_value > 0 && tokenBalanceLedger_[msg.sender] < _value){
       return false;
     }

    balance

   }


  /*==========================================
  =            INTERNAL FUNCTIONS            =
  ==========================================*/



/**
     * @dev Calculate Token price based on an amount of incoming ethereum
     *  It's an algorithm, hopefully we gave you the whitepaper with it in scientific notation;
     *  Some conversions occurred to prevent decimal errors or underflows / overflows in solidity code.
     */
  /*  function ethereumToTokens_(uint256 _ethereum) internal view returns (uint256) {
        uint256 _tokenPriceInitial = tokenPriceInitial_ * 1e18;
        uint256 _tokensReceived =
         (
            (
                // underflow attempts BTFO
                SafeMath.sub(
                    (sqrt
                        (
                            (_tokenPriceInitial ** 2)
                            +
                            (2 * (tokenPriceIncremental_ * 1e18) * (_ethereum * 1e18))
                            +
                            ((tokenPriceIncremental_ ** 2) * (tokenSupply_ ** 2))
                            +
                            (2 * tokenPriceIncremental_ * _tokenPriceInitial*tokenSupply_)
                        )
                    ), _tokenPriceInitial
                )
            ) / (tokenPriceIncremental_)
        ) - (tokenSupply_);

        return _tokensReceived;
    } */


  /*=====================================
  =      HELPERS AND CALCULATORS        =
  =====================================*/

    /**
     * @dev Method to view the current Ethereum stored in the contract
     *  Example: totalEthereumBalance()
     */
    function totalEthereumBalance() public view returns (uint256) {
        return this.balance;
    }

    /// @dev Retrieve the total token supply.
    function totalSupply() public view returns (uint256) {
        return tokenSupply_;
    }    




  }

  /**
 * @title SafeMath
 * @dev Math operations with safety checks that throw on error
 */
library SafeMath {

    /**
    * @dev Multiplies two numbers, throws on overflow.
    */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }
        uint256 c = a * b;
        assert(c / a == b);
        return c;
    }

    /**
    * @dev Integer division of two numbers, truncating the quotient.
    */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        // assert(b > 0); // Solidity automatically throws when dividing by 0
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold
        return c;
    }

    /**
    * @dev Substracts two numbers, throws on overflow (i.e. if subtrahend is greater than minuend).
    */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        assert(b <= a);
        return a - b;
    }

    /**
    * @dev Adds two numbers, throws on overflow.
    */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        assert(c >= a);
        return c;
    }

}

