pragma solidity ^0.4.22;


contract Betting {

/* Standard state variables */
    address public owner;
    address public oracle;

  /* owner funds mapping */
  mapping (address => uint) public ownerFundCounter;
   // address public gamblerA;
   // address public gamblerB;

    uint[] public outcomes;             // Representing an outcome
    uint   public totalBatAmount;
    uint   public houseBetNumber;            // Betting Counter

/* Structs are custom data structures with self-defined parameters */
    struct Bet {
        uint outcome;
        uint bidAmount;
        uint winningAmount;
        uint bidNumber;
        bool initialized;
    }

    struct GamblerInfo {
        address gamblerAddress;
    //    uint bidAmount;
    }

/* Keep track of every gambler's bet */
	mapping (address => Bet) bets;
    
/* Keep track of gambler info */  
  GamblerInfo [] public gamblerInfo;

/* Add any events you think are necessary */
    event BetMade(address gambler);
    event BidWinner(address gambler);
    event NoWinner();
    event BetClosed(uint bidNumber);

constructor(uint[] _possibleOutcomes) public {
    houseBetNumber = 1;                         // Initilized the bet number
    owner = msg.sender;
    outcomes = _possibleOutcomes;
    ownerFundCounter[owner] = 0;                // Setting Owner Contract Balance 
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
          ownerFundCounter[oracle] = 0;                // Setting Owner Contract Balance 
        return oracle;
    }

  /* Gamblers place their bets, preferably after calling checkOutcomes */
    function submitBet(uint _outcome) public gamblerOnly() payable returns (bool) {
        require(msg.sender != oracle);
        require(!bets[msg.sender].initialized);                                // user cannot double bet
        /** Check if BidClose Event is transmitted */

        uint winningAmount = bets[gambler].winningAmount;
                    // Number of bids played by user
        GamblerInfo memory gamblerObj;
        
        address gambler = msg.sender;

    if (!bets[gambler].initialized) {
       uint bidNumber = bets[gambler].bidNumber + 1;                     // Adding the number of games he / she played
            bets[gambler] = Bet(_outcome, msg.value, winningAmount,bidNumber, true);


            gamblerObj.gamblerAddress = gambler;
         // gamblerObj.bidAmount = _outcome;
            gamblerInfo.push(gamblerObj)-1;                             // Indexing the bidders addresess for Loop
            
       emit BetMade(gambler);
            totalBatAmount += msg.value;
            return true;
    } else {
           return false; // Bets already exist for gambler
    }
  }

  function openBid(uint _outcomeByOracle) public {
    emit BetClosed(houseBetNumber);                     // No More bets accepted
    uint loopRun = gamblerInfo.length;
    uint i = 0;
    address winner;
    bool noWinner = true;

    while ( i < loopRun){
      winner = gamblerInfo[i].gamblerAddress;
      if (_outcomeByOracle == bets[winner].bidNumber){
        /* Address is the winner, Add total amount to his winning amount and transfer the amount */
        /* In the next section, we will give flexibility that use can withdraw funds at the end of the game */
        bets[winner].winningAmount += totalBatAmount;
        noWinner = false;
        emit BidWinner(winner);
        break;                                            // In Version only one winner is allowed, who made the correct bit 1st
      }
      loopRun++;
    }
      if(noWinner){
        ownerFundCounter[oracle] += totalBatAmount;
        emit NoWinner();
      }
      houseBetNumber++;                                   // Increment house bet number for next round
  }

 /* Withdraw the winnings safely (if they have enough) */
    function withdraw(uint withdrawAmount) public returns (uint) {
      if(msg.sender == oracle){
        require(ownerFundCounter[msg.sender] >= withdrawAmount);
         ownerFundCounter[oracle] -= withdrawAmount;
         
        /* Trasfer funds to Oracle */
        if(!oracle.send(totalBatAmount))
            ownerFundCounter[oracle] += withdrawAmount;
        return (ownerFundCounter[oracle]);                   // return the remaining winnings

      }else{
        require(bets[msg.sender].winningAmount >= withdrawAmount);
           bets[msg.sender].winningAmount -= withdrawAmount;
        if(!msg.sender.send(withdrawAmount))
            bets[msg.sender].winningAmount += withdrawAmount;

         return (bets[msg.sender].winningAmount);                   // return the remaining winnings
      }
    }


// Append right after function declaration
function changeOwner(address newOwner) onlyAfter(now) ownerOnly() public {
    owner = newOwner;
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

  modifier onlyAfter(uint _time) { if (now <= _time) revert(); _; }

// modifier onlyIfState (state currState) { if (currState != State.A) _; }
//modifier validBalanceOnly(bidValue) { if (msg.value > bidValue) _;}  // I need to validate this in next level #2

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
