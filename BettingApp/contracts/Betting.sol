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



  constructor() public {
    owner = msg.sender;
    oracle = 0xF5302B50c357045Ca6b326acCF31c758e9AcDDe3;
  }

  function placeBid() public {

  }

// C. Modifiers
// Modifiers validate inputs to functions such as minimal balance or user auth;
// similar to guard clause in other languages
// '_' (underscore) often included as last line in body, and indicates
// function being called should be placed there
// Example modifier onlyAfter(uint _time) { if (now <= _time) throw; _ }

modifier onlyOwner { 
     if (msg.sender == owner) 
       _;
    }

modifier onlyAfter(uint _time) { if (now <= _time) revert(); _; }

//modifier onlyIfState (state currState) { if (currState != State.A) _; }

// underscore can be included before end of body,
// but explicitly returning will skip, so use carefully
modifier checkValue(uint amount) {
      _;
  if (msg.value > amount) {
      uint amountToRefund = amount - msg.value;
  if (!msg.sender.send(amountToRefund)) {
       revert();
    }
  }
}


// Append right after function declaration
function changeOwner(address newOwner) onlyAfter(now) onlyOwner()
        // onlyIfState(State.A)
{
owner = newOwner;
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
