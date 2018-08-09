
// Get an instance of the contract 
var Betting = artifacts.require("./Betting.sol");

module.exports = function(deployer) {
  deployer.deploy(Betting);
};
