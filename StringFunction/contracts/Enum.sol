pragma solidity ^0.4.22;


contract Enum {
enum  TimeUnit  {Minute, Hour, Day}
    address contractOwner;
    
    constructor() public {
        contractOwner = msg.sender;
    }
    
    /**
    * Calculates the time in future
    * Takes a number & a unit for the number e.g., 10 minute, 10 Hour
    **/
    function  calculateFutureTime(uint distance, uint units)  public view returns (uint) {
        if (units == uint(TimeUnit.Minute)) {
            return (now + distance*1 minutes);
        } else if (units == uint(TimeUnit.Hour)) {
            return (now + distance*1 hours);
        } else if (units == uint(TimeUnit.Day)) {
            return (now + distance*1 days);
        }
        return 1;
    }
}
