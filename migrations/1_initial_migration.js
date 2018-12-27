var Web3 = require('web3');
var Migrations = artifacts.require("./Migrations.sol");
var EnySaTsiaVoting = artifacts.require("./EnySaTsiaVoting.sol");

var web3 = new Web3();

module.exports = function(deployer) {
  deployer.deploy(Migrations);
  deployer.deploy(EnySaTsiaVoting, web3.utils.fromAscii('session0'));
};
