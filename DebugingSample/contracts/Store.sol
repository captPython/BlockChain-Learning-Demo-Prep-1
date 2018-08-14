pragma solidity ^0.4.22;


contract Store {
  uint storageVariable;
  address owner;

  event numberStoredBig(uint _num);
  event numberStoredSmall(uint _num);

  constructor() public {
    owner = msg.sender;
  }

  function setVariable(uint _num) public {
  /* Infinite loop for debugging # 1
    while(true){
      storageVariable = _num;
    } */

  /* #2 using assert statement : Smart contracts can use statements like assert() to ensure that certain conditions are met. 
  These can conflict with the state of the contract in ways that are irreconcilable.*/
  //  assert(_num == 0);
    storageVariable = _num;
    if(storageVariable > 10){
      emit numberStoredSmall(_num);    

    } else
      emit numberStoredBig(_num);         // Intentional Mistake

    }
  }

  function getNumber() public view returns(uint){
    return storageVariable;
  }
}
