import { ethers } from "hardhat";
import { ContractInterface } from "ethers";

const contractArtifact = require("../artifacts/contracts/IngesterOrchestratorV2/IngesterOrchestratorV2.sol/IngesterOrchestratorV2.json");
const abi = contractArtifact.abi as ContractInterface;
// Define an async function to interact with the smart contract
async function main() {
  // Replace the following values with your contract's details
  const contractAddress = '0x29B9E8a7B438e19A59Af2FeF2E094cbcF7446413';
  // Get the signer to interact with the Ethereum network
  const [signer, test1, test2] = await ethers.getSigners();

  // Create a contract instance using the signer, ABI, and contract address
  const contractInstance = new ethers.Contract(contractAddress, abi, signer);

  let res = await contractInstance.getIngester(test2.address);
  console.log("🚀 ~ file: interactDeployedSmartContract.ts:26 ~ main ~ res:", res)
}

// Execute the main function and catch any errors
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
