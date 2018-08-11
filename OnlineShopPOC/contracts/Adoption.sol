pragma solidity ^0.4.22;


contract Adoption {

  address[16] public adopters;    // An Array for adopters
  address contractOwner;

  // constructor
  constructor() public {
    contractOwner = msg.sender;
  }

// Adopting a pet
function adopt(uint petId) public returns (uint) {
  require(petId >= 0 && petId <= 15);

  adopters[petId] = msg.sender;

  return petId;
  }

// Retrieving the adopters (default getter function only returns the single value)
function getAdopters() public view returns (address[16]) {
  return adopters;
}

}
