var CertificateRegister = artifacts.require("./CertificateRegister.sol");
var _sealdata = artifacts.require("./SealData.sol");

module.exports = function(deployer) {
  deployer.deploy(CertificateRegister);
  deployer.deploy(_sealdata);
};
