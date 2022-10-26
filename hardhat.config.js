require("@nomicfoundation/hardhat-toolbox");
const ALCHEMY_API_KEY = "HCc-rZb1NYU1tTC6jtm2EpcZ0jAuZpGm";

// Replace this private key with your Goerli account private key
// To export your private key from Metamask, open Metamask and
// go to Account Details > Export Private Key
// Beware: NEVER put real Ether into testing accounts
const GOERLI_PRIVATE_KEY = "f34a1a59c2e4bf11b60acc7f77788e99b7b711f3285eaad4408fc7dfbe1341dc";
/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.17",
  networks: {
    goerli: {
      url: `https://eth-goerli.alchemyapi.io/v2/${ALCHEMY_API_KEY}`,
      accounts: [GOERLI_PRIVATE_KEY]
    }
  }  
};
