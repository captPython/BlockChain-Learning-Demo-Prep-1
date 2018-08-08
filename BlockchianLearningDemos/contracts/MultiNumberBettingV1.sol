pragma solidity ^0.4.22;

contract MultiNumberBettingV1 {

    uint loserCount;
    uint winnerCount;
    uint8[3] storageArray;

    function guess(uint8 betNumber) public returns(bool) {

     for(uint8 i=0; i < storageArray.length; i++){
        if (storageArray[i] == betNumber) {
        // Increase the winner count
          winnerCount++;
          return true;
        } 
     }
     
    loserCount++;
    return false;
    } 

    function totalGuesses() public returns (uint){
      return (winnerCount+loserCount);
    }

     constructor(uint8 num1, uint8 num2, uint8 num3) public {
        storageArray[0] = num1;   // 0
        storageArray[1] = num2;   // 5
        storageArray[2] = num3;   // 7
    }   
}
