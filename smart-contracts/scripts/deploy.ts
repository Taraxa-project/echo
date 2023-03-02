import { ethers } from "hardhat";

async function main() {

  const IngesterRegistry = await ethers.getContractFactory("IngesterRegistry");
  const IngesterRegistryContract = await IngesterRegistry.deploy();

  await IngesterRegistryContract.deployed();
  console.log(`IngesterRegistry is deployed to ${IngesterRegistryContract.address}`);

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
