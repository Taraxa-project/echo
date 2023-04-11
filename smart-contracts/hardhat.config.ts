import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

const config: HardhatUserConfig = {
  solidity: {
    version: "0.8.14",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200 // Adjust this value to a lower number to trade off bytecode size for gas efficiency
      }
    }
  },
  mocha: {
    timeout: 5000000
  },
  gasReporter: {
    enabled:true
  },
  networks: {
   
    hardhat: {
        accounts: {
          mnemonic: "test test test test test test test test test test test junk",
          path: "m/44'/60'/0'/0",
          initialIndex: 0,
          count: 100,
          passphrase: "",
        },
      },
    }
};

export default config;
