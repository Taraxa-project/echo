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
    timeout: 10000000
  },
  gasReporter: {
    enabled:true
  },
  networks: {
    mainnet: {
      url: 'https://rpc.mainnet.taraxa.io/',
      accounts: [],
      chainId: 841,
      gas: 20000000, 
      gasPrice: 1, 
    },
    testnet: {
      url: 'https://rpc.testnet.taraxa.io/',
      accounts: [],
      chainId: 842, 
      gas: 20000000, 
      gasPrice: 1, 
    },
    devnet: {
      url: 'https://rpc.devnet.taraxa.io/',
      accounts: [],
      chainId: 843, 
      gas: 20000000, 
      gasPrice: 1, 
    },
    hardhat: {
        accounts: {
          mnemonic: "test test test test test test test test test test test junk",
          path: "m/44'/60'/0'/0",
          initialIndex: 0,
          count: 500,
          passphrase: "",
        },
        
      },
    }
};

export default config;
