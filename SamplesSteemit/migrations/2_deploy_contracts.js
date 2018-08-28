
// Get an instance of the contract 
var thisVariable = artifacts.require("./thisVariable.sol");

module.exports = function(deployer) {
  deployer.deploy(thisVariable);
};
