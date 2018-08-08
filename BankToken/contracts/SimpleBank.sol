pragma solidity ^0.4.22;


contract SimpleBank {

  mapping (address=>uint) private balances;
  address public owner;
  event LogDepositMade(address accountAddress, uint amount);

  constructor() public {
    owner = msg.sender; // msg.sender is Contract caller
  }

  function deposit() public payable returns (uint) {
    balances[msg.sender] += msg.value;

    emit LogDepositMade(msg.sender, msg.value);

    return balances[msg.sender]; 
  }

  function withdraw(uint withdrawAmount) public returns(uint){
       if(balances[msg.sender] >= withdrawAmount) {
          balances[msg.sender] -= withdrawAmount;

       if(!msg.sender.send(withdrawAmount)) {
          balances[msg.sender] += withdrawAmount;
         }
       }
    return balances[msg.sender];
  }

  function balance() constant public returns(uint){
     return balances[msg.sender];
  }

  function () {
    revert();
  }
}
