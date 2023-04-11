import { ethers } from "hardhat";

async function main() {
  const [deployer] = await ethers.getSigners();

  console.log('Deploying contracts with the account:', deployer.address);
  let maxNumberIngesterPerGroup = 1;

  const IngesterOrchestratorV2 = await ethers.getContractFactory('IngesterOrchestratorV2');
  const ingesterOrchestratorV2 = await IngesterOrchestratorV2.deploy(maxNumberIngesterPerGroup);
  await ingesterOrchestratorV2.deployed();

  console.log('IngesterOrchestratorV2 deployed at:', ingesterOrchestratorV2.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
