pragma solidity ^0.4.22;

contract CertificateRegister {

    address public owner;
    event CertificateRegistered(string indexed id, string indexed name, uint256 indexed date);
    
    struct Certificate
    {
        string  id;
        string  name;
        uint256 date;
    }
    
    mapping (bytes32 => Certificate) certificate;
    mapping (bytes32 => Certificate) certificate_by_names;

    constructor() public {
        owner = msg.sender;
    }
    
    function register_Certificate(string _id, string _name, uint256 _date) only_owner private
    {
        bytes32 _signature = keccak256(bytes(_id));          

        certificate[_signature].id      = _id;
        certificate[_signature].name    = _name;
        certificate[_signature].date    = _date;
        
        bytes32 _name_signature = keccak256(bytes(_name));

        certificate_by_names[_name_signature].id      = _id;
        certificate_by_names[_name_signature].name    = _name;
        certificate_by_names[_name_signature].date    = _date;
        
        emit CertificateRegistered(_id, _name, _date);
    }
    
    function get_Certificate_by_id(string _id) public constant returns (string, string, uint256)
    {
        bytes32 _signature = keccak256(bytes(_id));

        return(
            certificate[_signature].id,
            certificate[_signature].name,
            certificate[_signature].date
            );
    }
    
    function get_Certificate_by_name(string _name) public constant returns (string, string, uint256)
    {
        bytes32 _name_signature = keccak256(bytes(_name));
        return(
            certificate_by_names[_name_signature].id,
            certificate_by_names[_name_signature].name,
            certificate_by_names[_name_signature].date
            );
    }
    
    modifier only_owner
    {
        assert(msg.sender == owner);
        _;
    }
}