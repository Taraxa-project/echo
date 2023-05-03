import { ethers } from "hardhat";
import { BigNumber } from "ethers";

// Define an async function to interact with the smart contract
async function main() {
  // Replace the following values with your contract's details
  const contractAddress = '0xBa7985D19d58B51E5Cfb13b0F65ea745FcdC76Eb';
  const dataGatheringAddress  = '0x6476Bf67cAa29cCC3fb95aED6256372a16383306';
  const groupManagerAddress  = '0x310CbF7aAEA7A7284D36bf342847Ff408bE85d84';
  const registryAddress = '0xdfDD565118012207E309fE08c2A540c75e2a7b3A';
  // Get the signer to interact with the Ethereum network
  const accounts = await ethers.getSigners();
  const controller = accounts[0];
  const numIngesters = accounts.length - 1;
  
  const ingesterProxy = await ethers.getContractAt("IngesterProxy", contractAddress);
  const ingesterRegistry = await ethers.getContractAt("IngesterRegistry", registryAddress);
  const ingesterDataGathering = await ethers.getContractAt("IngesterDataGathering", dataGatheringAddress);
  const ingesterGroupManager = await ethers.getContractAt("IngesterGroupManager", groupManagerAddress);
  
  const maxGroupsPerIngester = BigNumber.from(await ingesterProxy.getMaxGroupsPerIngester()).toNumber();
  const maxGroupCapacity = numIngesters * maxGroupsPerIngester;
  
  console.log("🚀 ~ file: interactDeployedSmartContract.ts:31 ~ main ~ contractInstance:", ingesterProxy.address)

  const message = "hello";
  const nonce = 123;
  for (let i = 1; i < accounts.length; i++) {
    let hash = await ingesterProxy.hash(accounts[i].address, message, nonce);
    const sig = await controller.signMessage(ethers.utils.arrayify(hash));
    let txRegitration = await ingesterProxy.connect(controller).registerIngester(accounts[i].address, message, nonce, sig);
    await txRegitration.wait();
    console.log(`registered ingester: ${accounts[i].address} with controller: ${controller.address}`);
  }

  for (let i = 1; i < maxGroupCapacity; i++) {
    await (await ingesterProxy.addGroup(`group${i}`)).wait();
    let group = await ingesterProxy.getGroup(`group${i}`);
    console.log(`group : group${i} was added, group status: ${group.isAdded}`);
  }

  let ingesters = await ingesterProxy.getIngesters();
  console.log("🚀 ~ file: interactDeployedSmartContract.ts:53 ~ main ~ res:", ingesters)

  let groupCount = await ingesterProxy.getGroupCount();
  console.log("🚀 ~ file: interactDeployedSmartContract.ts:57 ~ main ~ groupCount:", groupCount)
}

// Execute the main function and catch any errors
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
