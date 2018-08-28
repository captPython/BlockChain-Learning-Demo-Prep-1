pragma solidity ^0.4.22;

import "./TokenFinalization.sol";
import "./TokenConfig.sol";
import "./SafeMath.sol";


contract RESTokenContract is TokenFinalization, TokenConfig  {
  using SafeMath for uint256;

  event TokensReclaimed(uint256 _amount);

  constructor() public constructor(TOKEN_NAME, TOKEN_SYMBOL, TOKEN_DECIMALS, TOKEN_TOTALSUPPLY, PUBLIC_RESERVED, PUBLIC_RESERVED_PERSENTAGE, 
  BOARD_RESERVED, BOARD_RESERVED_PERSENTAGE)  
  {
    
  }
}
