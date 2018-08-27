
/** Get an instance of the contract 
var _SampleZeppelin = artifacts.require("./SampleZeppelin.sol");

module.exports = function(deployer) {
  deployer.deploy(_SampleZeppelin);
};
 **/

const _SampleZepCrowdSale = artifacts.require('./SampleZepCrowdSale.sol');
const _SampleZeppelin = artifacts.require('./SampleZeppelin.sol');

module.exports = function(deployer, network, accounts) {
    const openingTime = web3.eth.getBlock('latest').timestamp + 2; // two secs in the future
    const closingTime = openingTime + 86400 * 20;                  // 20 days
    const rate = new web3.BigNumber(1000);
    const wallet = accounts[1];

    return deployer
        .then(() => {
            return deployer.deploy(_SampleZeppelin);
        })
        .then(() => {
            return deployer.deploy(
                _SampleZepCrowdSale,
                openingTime,
                closingTime,
                rate,
                wallet,
                _SampleZeppelin.address
            );
        });
};