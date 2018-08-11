pragma solidity ^0.4.22;


contract Concatenate {
  address contractOwner;
  string str1;
  string str2;

  int8[] array = [int8(1),2,3];


  constructor() public {
    contractOwner = msg.sender;
  }

  function strOperation() public{
      int8[] memory arrayMemory;
      byte[4] fixByteArry;

      
    //string memory word1;
    //word1 = words[0];
    //str2 = words[1][];
  }
}
