var thisVariable = artifacts.require("./thisVariable.sol");

contract('thisVariable', function(accounts) {
  it("should assert true", function(done) {
    var this_variable_1 = thisVariable.deployed();
    assert.isTrue(true);
    done();
  });
});
