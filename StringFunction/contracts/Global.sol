pragma solidity ^0.4.22;


contract Global {

  string  public lastCaller = "not-set";  

  constructor() public {
  }

    // Demonstrates the use of block object
    function  getBlockInformation() public view returns (uint number, bytes32 hash, address coinbase, uint difficulty) {
        number = block.number; // Previous block
        hash = blockhash(number-1); // -1 because excluding current
        // Current block
        coinbase = block.coinbase;  
        difficulty = block.difficulty;
    }  

    // Demonstrates the use of the msg object
    function getMsgInformation() public view returns (bytes data, bytes4  sig, address sender) {
        data = msg.data;
        sig = msg.sig;
        sender = msg.sender;
    }

    function  revertBehavior(string name) public returns (bool) {
        lastCaller = name;

        // Check if length of the string is zero
        if (bytes(name).length == 0) {
            revert();
        }

        // The above lines of code may be replaced with this
        //require(bytes(name).length > 0);
        return true;
    }



}
