
// Get an instance of the contract 
var _SampleZeppelin = artifacts.require("./SampleZeppelin.sol");

module.exports = function(deployer) {
  deployer.deploy(_SampleZeppelin);
};
