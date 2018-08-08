pragma solidity ^0.4.22;

contract MultiNumberBettingV4 {
   
   struct Winner {
      address winnerAddress;
      string name;
      uint guess;
      uint guessedAt;
   }
 
   // Winner winnerins;

    mapping(address=>Winner) winnersMapping;

  // Public to generate the getters
    uint public  loserCount;
    uint public  winnerCount;
    uint public lastWinnerAt;

   // string lastWinnerName;
    uint8[3] storageArray;

    address winner;

   constructor(uint8 num1, uint8 num2, uint8 num3) public {
        storageArray[0] = num1;   // 1
        storageArray[1] = num2;   // 3
        storageArray[2] = num3;   // 9
    }  

    function guess(uint8 betNumber, string name) public returns(bool) {
    
    for(uint8 i=0; i < storageArray.length; i++){
        if (storageArray[i] == betNumber) {
        // Increase the winner count
          winnerCount++;
          //lastWinnerName = name;
          //lastWinnerAt = block.timestamp;  // can also use now
          //winner = msg.sender;
          
          winnersMapping[msg.sender].winnerAddress = msg.sender;
          winnersMapping[msg.sender].name = name;
          winnersMapping[msg.sender].guess = betNumber;
          winnersMapping[msg.sender].guessedAt = block.timestamp;

          lastWinnerAt = block.timestamp;
          winner = msg.sender;

          // winnerins.winnerAddress = msg.sender;
          // winnerins.name = name;
          // winnerins.guess = betNumber;
          // winnerins.guessedAt = block.timestamp;

          return true;
        } 
     }
     
    loserCount++;
    return false;
    } 

  // Ex-3
 /* function getLastWinner() public view returns (string) {

      bytes memory nameBytes = bytes(lastWinnerName);
      // If no winner send "***"
      if (nameBytes.length == 0) {
        return "***";
      }

    string memory retString = new string(3);

    bytes memory toReturn = bytes(retString);

    // 2nd check to cover a winner name less than 3 bytes
    for (uint i = 0; (i < 3) && (i < nameBytes.length); i++) {
      toReturn[i] = nameBytes[i];
    }

    return string(toReturn);
  } */

  // Ex 4 

 // Remember winner holds the address of the winner so we are getting
  // the information from the winnersMapping for the address
  // all values will be 0x0 if winner=0x0 i.e., if there is no winner
  function getLastWinnerInfo() public returns ( address winnerAddress1,
                                         string  name1, 
                                         uint guess1,
                                         uint guessedAt1){

    winnerAddress1 = winnersMapping[winner].winnerAddress;
    name1 = winnersMapping[msg.sender].name;
    guess1 = winnersMapping[msg.sender].guess;
    guessedAt1 = winnersMapping[msg.sender].guessedAt;                              
      
  }

  function checkWinning(address winnerAddress) public view returns(  address checkWinnerAddress, 
                                                      string  checkWinnerName,
                                                      uint checkWinnerguessVal, 
                                                      uint checkWinnerguessedAt){
    Winner memory winnerLocal = winnersMapping[winnerAddress];
    if (winnerLocal.guessedAt != 0) {
      checkWinnerAddress = winnersMapping[winnerAddress].winnerAddress;
      checkWinnerName = winnersMapping[winnerAddress].name;
      checkWinnerguessVal = winnersMapping[winnerAddress].guess;
      checkWinnerguessedAt = winnersMapping[winnerAddress].guessedAt;
    }
  }

// Total Bet played in the game
  function totalGuesses() public view returns (uint){
      return (winnerCount+loserCount);
  }

  function daysSinceLastWinning() public view returns(uint){
    uint currentDateTime = block.timestamp;
    uint dayPassed;

    if (lastWinnerAt == 0) {
      return 0;
    } else {
     dayPassed = (currentDateTime - lastWinnerAt)/24;
     return dayPassed;
    }
  }
 
  function hoursSinceLastWinning() public view returns(uint){
    uint currentDateTime = block.timestamp;
    uint dayPassed;

    if (lastWinnerAt == 0) {
      return 0;
    } else {
     dayPassed = ((currentDateTime - lastWinnerAt)*60)/24;
     return dayPassed;
    }
  }

  function minutesSinceLastWinning() public view returns(uint){
    uint currentDateTime = block.timestamp;
    uint dayPassed;

    if (lastWinnerAt == 0) {
      return 0;
    } else {
     dayPassed = ((currentDateTime - lastWinnerAt)*60*60)/24;
     return dayPassed;
    }
  }

  function timeSinceLastWinner() private constant returns(uint) {
    uint timeSince = now - lastWinnerAt * 1 seconds;

    timeSince < now ? lastWinnerAt : 0;
  }
    
}
