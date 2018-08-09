pragma solidity ^0.4.22;


contract thisVariable {
  address ownerAddress;
  uint ownerBalance;

  constructor() public {
  }

  function updateInfo() public {
    ownerAddress = this;
    ownerBalance = address(ownerAddress).balance;
  }
}
