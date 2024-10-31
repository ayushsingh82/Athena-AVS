require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.27",
  networks: {
    hardhat: {},
    holesky: {
      url: "https://ethereum-holesky-rpc.publicnode.com",
      chainId: 17000,
    },
  },
};
