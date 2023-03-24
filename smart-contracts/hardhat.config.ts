import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

const config: HardhatUserConfig = {
  solidity: "0.8.14",
  mocha: {
    timeout: 5000000
  },
  gasReporter: {
    enabled:true,
    // outputFile: "gas-report.txt",
    // noColors: false
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
