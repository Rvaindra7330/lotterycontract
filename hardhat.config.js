require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();
const { INFURA_API_KEY, PRIVATE_KEY } = process.env;
/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.28",
  networks: {
    hardhat:{},
    sepolia: {
      url: `${INFURA_API_KEY}` ,
      accounts: [PRIVATE_KEY]
    },
  },
};
