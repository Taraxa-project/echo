import { ethers } from "hardhat";
import { BigNumber } from "ethers";

// Define an async function to interact with the smart contract
async function main() {
  // Replace the following values with your contract's details
  const contractAddress = '0x18D864D84471Ece5C10b9cfd3E1CF8ad9B07d89c';

  // Get the signer to interact with the Ethereum network
  const accounts = await ethers.getSigners();
  const controller = accounts[0];
  const numIngesters = accounts.length - 1;
  console.log("🚀 ~ file: interactDeployedSmartContract.ts:15 ~ main ~ numIngesters:", numIngesters)
  
  const accessControlFacet = await ethers.getContractAt("AccessControlFacet", contractAddress);
  const commonFunctionsFacet = await ethers.getContractAt("CommonFunctionsFacet", contractAddress);
  const dataGatheringFacet = await ethers.getContractAt("DataGatheringFacet", contractAddress);
  const groupManagerFacet = await ethers.getContractAt("GroupManagerFacet", contractAddress);
  const registryFacet = await ethers.getContractAt("RegistryFacet", contractAddress);
  console.log("🚀 ~ file: interactDeployedSmartContract.ts:20 ~ main ~ registryFacet:", registryFacet)
  
  const maxGroupsPerIngester = 200;//BigNumber.from(await groupManagerFacet.getMaxGroupsPerIngester()).toNumber();
  console.log("🚀 ~ file: interactDeployedSmartContract.ts:22 ~ main ~ maxGroupsPerIngester:", maxGroupsPerIngester)
  const maxGroupCapacity = 50;

  const message = "hello";
  const nonce = 123;
  for (let i = 1; i < accounts.length; i++) {
    console.log('hashing registry facet');
    let hash = await registryFacet.hash(accounts[i].address, message, nonce);
    const sig = await controller.signMessage(ethers.utils.arrayify(hash));
    let txRegitration = await registryFacet.connect(controller).registerIngester(accounts[i].address, message, nonce, sig);
    await txRegitration.wait();
    console.log(`registered ingester: ${accounts[i].address} with controller: ${controller.address}`);
  }
  //left at group200
  for (let i = 0; i < maxGroupCapacity; i++) {
    console.log("🚀 ~ file: interactDeployedSmartContract.ts:38 ~ main ~ i:", i)
    await (await groupManagerFacet.addGroup(`group${i}`)).wait();
    let group = await groupManagerFacet.getGroup(`group${i}`);
    console.log(`group : group${i} was added, group status: ${group.isAdded}`);
  }

  let ingesters = await registryFacet.getIngesters();
  console.log("🚀 ~ file: interactDeployedSmartContract.ts:53 ~ main ~ res:", ingesters)

  let groupCount = await registryFacet.getGroupCount();
  console.log("🚀 ~ file: interactDeployedSmartContract.ts:57 ~ main ~ groupCount:", groupCount)
}

// Execute the main function and catch any errors
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
