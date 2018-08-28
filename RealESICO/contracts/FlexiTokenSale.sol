pragma solidity ^0.4.22;

import "./Owned.sol";
import "./ERC20Interface.sol";
import "./SafeMath.sol";

contract FlexiTokenSale is  Owned, ERC20Interface {
      using SafeMath for uint256;

  // Token Sale Flag
  bool public suspended;

  /** Pricing */
  uint256 public tokenPrice;
  uint256 public tokenPerEther;
  uint256 public minimumContribution;
  uint256 public tokenConversionFactor;  

  address public walletAddress;

  ERC20Interface token;

  /** Counters */
  uint256 public totalTokensSold;
  uint256 public totalETHCollected;

  /** Price Update Address */
  address public priceUpdateAddress;

  event Initialized();
  event TokenPriceUpdated(uint256 _newValue);
  event TokenPerEtherUpdated(uint256 _newValue);
  event MinTokenUpdated(uint256 _newValue);
  event WalletAddressUpdated(address indexed _newAddress);
  event TokenSaleSuspended();
  event ToeknSaleResumed();
  event TokensPurchased(address indexed _beneficiary, uint256 _cost, uint256 _tokens);
  event ReclaimContractTokenBalance(uint256 _amount);
  event PriceAddressUpdated(address indexed _newAddress); 

  /** Constructor */
  constructor(address _tokenAddress,address _walletAddress,uint _tokenPerEther,address _priceUpdateAddress) 
  public Owned() {
      require(_walletAddress != address(0));         // Wallet address should not be null address
      require(_walletAddress != address(this));      // Wallet address should not be Contract address

      require(address(_tokenAddress) != address(0));
      require(address(_tokenAddress) != address(this));

      require(address(_tokenAddress) != address(walletAddress));

      walletAddress = _walletAddress;
      priceUpdateAddress = _priceUpdateAddress;
      token = ERC20Interface(_tokenAddress);

      suspended = false;
      tokenPrice = 100;
      tokenPerEther = _tokenPerEther;

      minimumContribution     = 1 * 10**18;          //minimum 1 RES token
      totalTokensSold     = 0;
      totalETHCollected = 0;      

    /** This factor is used when converting cost <-> tokens. */
    /** 18 is because of the ETH -> Wei conversion. */
    /** 2 because token price and etherPerToken Price are expressed as 100 for $1.00  and 100000 for $1000.00 (with 2 decimals). */
      tokenConversionFactor = 10**(uint256(18).sub(token.decimals()).add(2));
      assert(tokenConversionFactor > 0);
    }

    /** Management Function: Owner Configuation - Allows the owner to change the Token Sale Ether wallet address **/
     function setWalletAddress(address _walletAddress) external onlyOwner returns(bool) {
        require(_walletAddress != address(0));
        require(_walletAddress != address(this));
        require(isOwner(_walletAddress) == false);           // Wallet address should not belong to Owner Address

        walletAddress = _walletAddress;

        emit WalletAddressUpdated(_walletAddress);            // Emit the Event for wallet address 

        return true;
    }

    /** Management Function: Set token price in between $1 to $1000, pass 100 for $1, 100000 for $1000 */
    function setTokenPrice(uint _tokenPrice) external onlyOwner returns (bool) {
        require(_tokenPrice >= 100 && _tokenPrice <= 100000);

        tokenPrice = _tokenPrice;

        emit TokenPriceUpdated(_tokenPrice);
        return true;
    }

    /** Management Function: Setting min Token value,  Only executed by Owner */
    function setMinToken(uint256 _minToken) external onlyOwner returns(bool) {
        require(_minToken > 0);

        minimumContribution = _minToken;       // setting minimum Contribution to participate 

        emit MinTokenUpdated(_minToken);
        return true;
    }

    /* Management Function: Allows the owner to suspend the Sale */
    function suspend() external onlyOwner returns(bool) {
        if (suspended == true) { return false;}
          suspended = true;

       emit TokenSaleSuspended();
       return true;
    }

    /** Management Function: Allows the Owner to resume the Token Sale. */
    function resume() external onlyOwner returns(bool) {
        if (suspended == false) {return false;}
            suspended = false;
        
        emit ToeknSaleResumed();
        return true;
    }


  /** Management Function: Allows the owner to claim the tokens, assigned to the sale contract. */
    function reclaimContractTokenBalance() external onlyOwner returns (bool) {
        uint256 contractTokenBalance = token.balanceOf(address(this));

        if (contractTokenBalance == 0) { return false; }
        require(token.transfer(owner, contractTokenBalance));

        emit ReclaimContractTokenBalance(contractTokenBalance);
        return true;
    }  

    /** Default payable function for token purchase.*/
    function () payable public {
        buyTokens(msg.sender);
    }

    /** Allows the caller to purchase tokens for a specific beneficiary (proxy purchase). */
    function buyTokens(address _beneficiary) public payable returns (uint256) {
        require(!suspended);                                // SALE should not be suspended

        require(_beneficiary != address(0));
        require(_beneficiary != address(this));

        require(msg.sender != address(walletAddress));       // Avoid Toekn Purchase form Token Sale wallet

        // Check how many tokens are still available for sale.
        uint256 saleBalance = token.balanceOf(address(this));
        assert(saleBalance > 0);


        return _buyTokensInternal(_beneficiary);
    }
    /** Internal function for token purchase */
    function _buyTokensInternal(address _beneficiary) internal returns (uint256) {
        // Calculate how many tokens the contributor could purchase based on ETH received.
        uint256 tokens = msg.value.mul(tokenPerEther.mul(100).div(tokenPrice)).div(tokenConversionFactor);
        require(tokens >= minimumContribution);

        // This is the actual amount of ETH that can be sent to the wallet.
        uint256 contribution =msg.value;
        walletAddress.transfer(contribution);
        totalETHCollected = totalETHCollected.add(contribution);

        // Update our stats counters.
        totalTokensSold = totalTokensSold.add(tokens);

        // Transfer tokens to the beneficiary.
        require(token.transfer(_beneficiary, tokens));    // Add tokens to Smart Contract Balance 

        emit TokensPurchased(_beneficiary, msg.value, tokens);
        return tokens;
    }    
  
}
