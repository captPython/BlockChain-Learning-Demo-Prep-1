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

  function withdraw(uint withdrawAmount) 
           onlyOwner() 
           checkValue(withdrawAmount) public returns(uint){
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

/* C. Modifiers
// Modifiers validate inputs to functions such as minimal balance or user auth;
// similar to guard clause in other languages
// '_' (underscore) often included as last line in body, and indicates **/

modifier onlyOwner { 
     if (msg.sender == owner) 
       _;
    }

modifier onlyAfter(uint _time) { if (now <= _time) revert(); _; }

/* modifier onlyIfState (state currState) { if (currState != State.A) _; }
   underscore can be included before end of body,
   but explicitly returning will skip, so use carefully **/
modifier checkValue(uint amount) {
      _;
  if (msg.value > amount) {
      uint amountToRefund = amount - msg.value;
  if (!msg.sender.send(amountToRefund)) {
       revert();
    }
  }
}

/* Fallback function - Called if other functions don't match call or
   sent ether without data
   Typically, called when invalid data is sent
   Added so ether sent to this contract is reverted if the contract fails 
   otherwise, the sender's money is transferred to contract **/
  function () {
    revert(); // reverts state to before call
  }
}
