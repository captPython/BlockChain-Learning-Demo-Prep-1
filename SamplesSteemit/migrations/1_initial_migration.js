var Migrations = artifacts.require("./Migrations.sol");
var Migrations = artifacts.require("./thisVariable.sol");


module.exports = function(deployer) {
  deployer.deploy(Migrations);
  deployer.deploy(thisVariable);
};
