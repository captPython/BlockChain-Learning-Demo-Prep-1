pragma solidity ^0.4.22;

import 'zeppelin-solidity/contracts/token/ERC20/MintableToken.sol';

contract SampleZeppelin is MintableToken {
  string public name = "Zepplin Sample Coin";
  string public symbol = "ZSC";
  uint8 public decimals = 18;

  constructor() {
  }
}
