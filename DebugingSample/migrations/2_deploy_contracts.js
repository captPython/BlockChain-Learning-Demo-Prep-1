
// Get an instance of the contract 
var Store = artifacts.require("./Store.sol");

module.exports = function(deployer) {
  deployer.deploy(Store);
};
