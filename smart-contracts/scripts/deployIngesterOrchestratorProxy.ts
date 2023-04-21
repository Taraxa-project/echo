import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";
import { ethers } from "hardhat";

let maxIngesterPerGroup = 1;
const maxClusterSize = 3;
const maxGroupsPerIngester = 200;

async function deployDataGetheringContract(deployer: SignerWithAddress) {
    const IngesterDataGathering = await ethers.getContractFactory("IngesterDataGathering", deployer);
    const ingesterDataGathering = await IngesterDataGathering.deploy();
    await ingesterDataGathering.deployed();
    return ingesterDataGathering;
}

async function deployRegistryContract(deployer: SignerWithAddress) {
    const IngesterRegistry = await ethers.getContractFactory("IngesterRegistry", deployer);
    const ingesterRegistry = await IngesterRegistry.deploy();
    await ingesterRegistry.deployed();
    return ingesterRegistry;
}

async function deployGroupManagerContract(deployer: SignerWithAddress) {
    const IngesterGroupManager = await ethers.getContractFactory("IngesterGroupManager", deployer);
    const ingesterGroupManager = await IngesterGroupManager.deploy(maxClusterSize, maxGroupsPerIngester, maxIngesterPerGroup);
    await ingesterGroupManager.deployed();
    return ingesterGroupManager;
}

async function deployIngesterProxyContract(deployer: SignerWithAddress, ingesterGroupManagerAddress: string, ingesterRegistryAddress: string, ingesterDataGatheringAddress: string) {
    const IngesterProxy = await ethers.getContractFactory("IngesterProxy", deployer);
    const ingesterProxy = await IngesterProxy.deploy(ingesterGroupManagerAddress, ingesterRegistryAddress, ingesterDataGatheringAddress);
    await ingesterProxy.deployed();
    return ingesterProxy;
}

async function main() {
  const [deployer] = await ethers.getSigners();

  const ingesterDataGathering = await deployDataGetheringContract(deployer);
  const ingesterRegistry = await deployRegistryContract(deployer);
  const ingesterGroupManager = await deployGroupManagerContract(deployer);
  
  const ingesterProxy = await deployIngesterProxyContract(deployer, ingesterGroupManager.address, ingesterRegistry.address, ingesterDataGathering.address);
  
  await ingesterDataGathering.connect(deployer).updateIngesterProxy(ingesterProxy.address);
  await ingesterGroupManager.connect(deployer).updateIngesterProxy(ingesterProxy.address);
  await ingesterRegistry.connect(deployer).updateIngesterProxy(ingesterProxy.address);
  
  console.log('Deploying contracts with the account:', deployer.address);
  console.log('Ingester Orchestrator Proxy deployment address: ', ingesterProxy.address );
  console.log('Ingester Data Gathering deployment address: ', ingesterDataGathering.address );
  console.log('Ingester Group Manager deployment address: ', ingesterRegistry.address );
  console.log('Ingester Registraty deployment address: ', ingesterGroupManager.address );
  
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
