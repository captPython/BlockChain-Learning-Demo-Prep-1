var Migrations = artifacts.require("./Migrations.sol");
var Migrations = artifacts.require("./SimpleBank.sol");

module.exports = function(deployer) {
  deployer.deploy(Migrations);
  deployer.deploy(SimpleBank);
};
