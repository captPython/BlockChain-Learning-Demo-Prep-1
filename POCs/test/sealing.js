contract('sealing', function(accounts) {
  it("should assert true", function(done) {
    var sealing = sealing.deployed();
    // Get the instance of deployed contract 
    /**
     * truffle.cmd development
     * var _sealdata = <ContractName>.at(<ContractName>.address)  // Thisi is to retrive the instance of Contract deployed at perticular address
     * _sealdata.sealData("This is the Sample Data")    // Seal the data, hash of this data will be stored as a State Var in Contract
     * _sealdata.sealFor("This is the Sample Data")      //Get the seal for a data sample, This will provide the hash for this string
     *  _sealdata.existanceproof()                     .//Now get the has stored for our Sample data, if it matches with above hash
     *                                                  //that mean supplied data is out data 
     */
  });
});
