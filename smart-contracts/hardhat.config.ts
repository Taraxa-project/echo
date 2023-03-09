import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

const config: HardhatUserConfig = {
  solidity: "0.8.14",
  gasReporter: {
    enabled:true,
    // outputFile: "gas-report.txt",
    // noColors: false
  }
};

export default config;
