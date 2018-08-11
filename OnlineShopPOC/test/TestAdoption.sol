pragma solidity ^0.4.22;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Adoption.sol";

contract TestAdoption {
  Adoption adoption = Adoption(DeployedAddresses.Adoption());

  // Testing the adopt() function
function testUserCanAdoptPet() public {
  uint returnedId = adoption.adopt(10);

  uint expected = 10;

  Assert.equal(returnedId, expected, "Adoption of pet ID 10 should be recorded.");
  }

// Testing retrieval of a single pet's owner
function testGetAdopterAddressByPetId() public {
  /* Since the TestAdoption contract will be sending the transaction, we set the expected 
     value to this, a contract-wide variable that gets the current contract's address */
  address expected = this;                   // Expected owner is this contract

  address adopter = adoption.adopters(10);

  Assert.equal(adopter, expected, "Owner of pet ID 10 should be recorded.");
  }

// Testing retrieval of all pet owners
function testGetAdopterAddressByPetIdInArray() public {
  // Expected owner is this contract
    address expected = this;
  // Store adopters in memory rather than contract's storage
    address[16] memory adopters = adoption.getAdopters();
    Assert.equal(adopters[10], expected, "Owner of pet ID 10 should be recorded.");
  }    
}
