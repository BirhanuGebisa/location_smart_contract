const refund_location = artifacts.require('refund_location')

module.exports = function (deployer) {
  deployer.deploy(refund_location)
}