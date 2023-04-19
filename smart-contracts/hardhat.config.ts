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
    // taraxa_testnet: {
    //   url: 'https://rpc.testnet.taraxa.io/',
    //   accounts: [''],
    //   chainId: 842, // Replace with Taraxa testnet's chainId
    //   gas: 10000000, // Custom gas limit; adjust this value as needed
    //   gasPrice: 1000000000, // Custom gas price in gwei; adjust this value as needed (1 gwei in this example)
    // },
    // taraxa_devnet: {
    //   url: 'https://rpc.devnet.taraxa.io/',
    //   accounts: [''],
    //   chainId: 843, // Replace with Taraxa testnet's chainId
    //   gas: 100000000000, // Custom gas limit; adjust this value as needed
    //   gasPrice: 1000000000, // Custom gas price in gwei; adjust this value as needed (1 gwei in this example)
    // },
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
