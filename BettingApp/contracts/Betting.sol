pragma solidity ^0.4.22;


contract Betting {

	/* Standard state variables */

address public owner;
address public player1;
address public player2;
address public oracle;



struct bid{
  uint bidAmount;
  uint expectedOutcome;
  bool BidStatus;
}



  constructor() {
    owner = msg.sender;
    oracle = 0xF5302B50c357045Ca6b326acCF31c758e9AcDDe3;
  }

  function placeBid() public {

  }

// Fallback function - Called if other functions don't match call or
// sent ether without data
// Typically, called when invalid data is sent
// Added so ether sent to this contract is reverted if the contract fails
// otherwise, the sender's money is transferred to contract
  function () {
    revert(); // reverts state to before call
  }
}
