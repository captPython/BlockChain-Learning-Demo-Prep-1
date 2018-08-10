pragma solidity ^0.4.22;


contract Betting {

/* Standard state variables */
    address public owner;
    address public oracle;
   // address public gamblerA;
   // address public gamblerB;

    uint[] public outcomes;    // Representing an outcome

/* Structs are custom data structures with self-defined parameters */
    struct Bet {
        uint outcome;
        uint amount;
        bool initialized;
    }

/* Keep track of every gambler's bet */
	mapping (address => Bet) bets;

/* Add any events you think are necessary */
    event BetMade(address gambler);
    event BetClosed();

constructor(uint[] _possibleOutcomes) public {
    owner = msg.sender;
    outcomes = _possibleOutcomes;
   /* for(uint i=0; i < _possibleOutcomes.length; i++){
      Question : what is the difference if I will not run the loop and just assign the arrays
      Check during testing
    } */
  }

   /* Owner chooses their trusted Oracle */
    function chooseOracle(address _oracle) public ownerOnly() returns (address) {
    //    require(_oracle != gamblerA && _oracle != gamblerB);    // Make sure no gamblers are selected as the oracle
        require(_oracle != owner);                              // Make sure owner cannot select himself/herself as the oracle
          oracle = _oracle;                                      /* Vulnerability in human trust */
        return oracle;
    }

  /* Gamblers place their bets, preferably after calling checkOutcomes */
    function makeBet(uint _outcome) public gamblerOnly() payable returns (bool) {
        require(msg.sender != oracle);
        require(!bets[msg.sender].initialized); // user cannot double bet
        
        address gambler = msg.sender;

         if (!bets[gambler].initialized) {
            bets[gambler] = Bet(_outcome, msg.value, true);
            emit BetMade(gambler);
            return true;
        } else {
           return false; // Bets already exist for gambler
        }
    }

  function checkBid(uint [] bidArray) public {

  }

// C. Modifiers
// Modifiers validate inputs to functions such as minimal balance or user auth;
// similar to guard clause in other languages
// '_' (underscore) often included as last line in body, and indicates
// function being called should be placed there
// Example modifier onlyAfter(uint _time) { if (now <= _time) throw; _ }
  modifier ownerOnly() { if (msg.sender == owner) _;}

  modifier oracleOnly() { if (msg.sender == oracle) _;}

  modifier gamblerOnly() { if (!(msg.sender == oracle) || !(msg.sender == owner)) _;}
  
  //modifier validBalanceOnly(bidValue) { if (msg.value > bidValue) _;}  // I need to validate this in next level #2

  modifier onlyAfter(uint _time) { if (now <= _time) revert(); _; }

// modifier onlyIfState (state currState) { if (currState != State.A) _; }

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
function changeOwner(address newOwner) onlyAfter(now) ownerOnly(){
    owner = newOwner;
}


// Fallback function - Called if other functions don't match call or
// sent ether without data
// Typically, called when invalid data is sent
// Added so ether sent to this contract is reverted if the contract fails
// otherwise, the sender's money is transferred to contract
    /* Fallback function */
function() public payable {
    revert();
}
}
