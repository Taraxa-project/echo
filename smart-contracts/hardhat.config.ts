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
    taraxa_testnet: {
      url: 'https://rpc.testnet.taraxa.io/',
      accounts: ['d32ee7d133502be3c6d3d4676723f0249cdcfa712a34dc20be4ee59bd83c9a4b'],
      chainId: 842, // Replace with Taraxa testnet's chainId
      gas: 10000000, // Custom gas limit; adjust this value as needed
      gasPrice: 1000000000, // Custom gas price in gwei; adjust this value as needed (1 gwei in this example)
    },
    taraxa_devnet: {
      url: 'https://rpc.devnet.taraxa.io/',
      accounts: ['d32ee7d133502be3c6d3d4676723f0249cdcfa712a34dc20be4ee59bd83c9a4b', 'c04ac6cca90ac5cc097cacb118ddc8d144a9120df2afcfe0abd85a95c94abdfb', '1ac788aef8224880caafa855b193633566006c5eb5d14382ad4ec57fe860d334'],
      chainId: 843, // Replace with Taraxa testnet's chainId
      gas: 100000000000, // Custom gas limit; adjust this value as needed
      gasPrice: 1000000000, // Custom gas price in gwei; adjust this value as needed (1 gwei in this example)
    },
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
