pragma solidity ^0.4.22;


// ----------------------------------------------------------------------------
// Owned contract
// ----------------------------------------------------------------------------
contract Owned {
    address public owner;
    address public newOwner = address(0);

  //  event OwnershipTransferInitiated(address indexed _proposedOwner);
    event OwnershipTransferred(address indexed _from, address indexed _to);    
    event OwnershipTransferCompleted(address indexed _newOwner);
    event OwnershipTransferCanceled();


    constructor() public {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    function isOwner(address _address) public view returns (bool) {
        return (_address == owner);
    }
    
    function transferOwnership(address _newOwner) public onlyOwner {
        newOwner = _newOwner;
    }

    // New Owner will cliam the owner ship by executing the function
    
    function acceptOwnership() public {
        require(msg.sender == newOwner);
        owner = newOwner;
        emit OwnershipTransferred(owner, newOwner);        
        newOwner = address(0);
    }
}