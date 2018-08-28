pragma solidity ^0.4.22;

import "./ERC20Token.sol";
import "./Owned.sol";
import "./SafeMath.sol";

contract TokenFinalization is Owned, ERC20Token {
  using SafeMath for uint256;

    address public publicReservedAddress;
    
    /** Board members Account list */
    mapping(address=>uint) private boardReservedAccount;
    uint256[] public BOARD_RESERVED_YEARS = [1 years,2 years,3 years,4 years,5 years];

    event Burn(address indexed burner,uint256 value);


    constructor(string _name, string _symbol, uint8 _decimals, uint256 _totalSupply,
                        address _publicReserved,uint256 _publicReservedPersentage,address[] _boardReserved,
                        uint256[] _boardReservedPersentage) public
    ERC20Token(_name, _symbol, _decimals, _totalSupply, _publicReserved, _publicReservedPersentage, _boardReserved,
                _boardReservedPersentage) Owned() {
        
        publicReservedAddress = _publicReserved;
        for(uint i=0; i<_boardReserved.length; i++){
            boardReservedAccount[_boardReserved[i]] = now + BOARD_RESERVED_YEARS[i];
            }
        }  

    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(_validateTransfer(msg.sender, _to));
        return super.transfer(_to, _value);
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(_validateTransfer(msg.sender, _to));
        return super.transferFrom(_from, _to, _value);
    }


    function _validateTransfer(address _sender, address _to) private view returns(bool) {
        require(_to != address(0));                                            // Check null address
        uint256 time = now - boardReservedAccount[_sender];                   // Check time remaing for board member address

        if (time == 0) {                                                     // if not then return and allow for transfer
            return true;
        }else{                                                              // else  then check allowed token for board member  
            return false;
        }
    }

    /**
     * @dev Burns a specific amount of tokens.
     * @param _value The amount of token to be burned.
     */
    function burn(uint256 _value) public {
        require(_value > 0);
        require(_value <= balanceOfAccounts[msg.sender]);

        address burner = msg.sender;
        balanceOfAccounts[burner] = balanceOfAccounts[burner].sub(_value);
        tokenTotalSupply = tokenTotalSupply.sub(_value);                
        emit Burn(burner, _value);
    }

}
