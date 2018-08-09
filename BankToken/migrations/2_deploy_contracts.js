
// Get an instance of the contract 
var SimpleBank = artifacts.require("./SimpleBank.sol");

module.exports = function(deployer) {
  deployer.deploy(SimpleBank);
};
