pragma solidity ^0.4.18;

contract SimpleStorage {
  uint ipfsHash;

  function set(uint x) public {
    ipfsHash = x;
  }

  function get() public view returns (uint) {
    return ipfsHash;
  }
}
