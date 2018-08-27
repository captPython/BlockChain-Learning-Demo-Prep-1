pragma solidity ^0.4.22;


contract SealData {
  // Document State
  bytes32 public existanceproof;

  // Calculate and Seal the proof for a data
  function sealData(string _data) public {
    existanceproof = sealFor(_data);
  }

  // helper function to get a document's sha256
  function sealFor(string _data) public view returns (bytes32) {
    return keccak256(bytes(_data));
  }

}
