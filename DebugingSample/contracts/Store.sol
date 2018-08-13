pragma solidity ^0.4.22;


contract Store {
  uint storageVariable;

  event numberStored(uint);

  constructor() public {
  }

  function setVariable(uint _num) public {
    storageVariable = _num;
    emit numberStored(_num);
  }

  function getNumber() public view returns(uint){
    return storageVariable;
  }
}
