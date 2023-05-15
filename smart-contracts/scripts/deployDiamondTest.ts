/* global ethers */
/* eslint prefer-const: "off" */

import { ContractReceipt, Transaction } from "ethers";
import { TransactionDescription, TransactionTypes } from "ethers/lib/utils";
import { ethers } from "hardhat";
import { DiamondCutFacet, DiamondInit } from "../typechain-types";
import { getSelectors, FacetCutAction } from "./libraries/diamond";

export let DiamondAddress: string;
export const maxClusterSize = 3;
export const maxGroupsPerIngester = 50;
export const maxIngestersPerGroup = 1;

export async function deployDiamondTest(verbose=false) {
  const accounts = await ethers.getSigners();
  const contractOwner = accounts[0];

  // deploy DiamondInit
  // DiamondInit provides a function that is called when the diamond is upgraded to initialize state variables
  // Read about how the diamondCut function works here: https://eips.ethereum.org/EIPS/eip-2535#addingreplacingremoving-functions
  const DiamondInit = await ethers.getContractFactory("DiamondInit");
  const diamondInit = await DiamondInit.deploy();
  await diamondInit.deployed();
  
  // deploy facets
  if (verbose){
    console.log("DiamondInit deployed:", diamondInit.address);
    console.log("");
    console.log("Deploying facets");
  }

  const FacetNames = ["DiamondCutFacet", "DiamondLoupeFacet", "OwnershipFacet"];
  const facetCuts = [];
  for (const FacetName of FacetNames) {
    const Facet = await ethers.getContractFactory(FacetName);
    const facet = await Facet.deploy();
    await facet.deployed();

    verbose ?? console.log(`${FacetName} deployed: ${facet.address}`);

    facetCuts.push({
      facetAddress: facet.address,
      action: FacetCutAction.Add,
      functionSelectors: getSelectors(facet),
    });
  }

  // Creating a function call
  // This call gets executed during deployment and can also be executed in upgrades
  // It is executed with delegatecall on the DiamondInit address.
  let initArgs: DiamondInit.ArgsStruct = {maxClusterSize, maxGroupsPerIngester, maxIngestersPerGroup};

  let functionCall = diamondInit.interface.encodeFunctionData('init', [initArgs]);

  // Setting arguments that will be used in the diamond constructor
  const diamondArgs = {
    owner: contractOwner.address,
    init: diamondInit.address,
    initCalldata: functionCall,
  }

  // deploy Diamond
  const Diamond = await ethers.getContractFactory('Diamond')
  const diamond = await Diamond.deploy(facetCuts, diamondArgs)
  await diamond.deployed()

  verbose ?? console.log('Diamond deployed:', diamond.address)
  const diamondAddress = diamond.address

  // returning the address of the diamond
  return {diamondAddress, contractOwner};
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
if (require.main === module) {
  deployDiamondTest(true)
    .then(() => process.exit(0))
    .catch((error) => {
      console.error(error);
      process.exit(1);
    });
}

exports.deployDiamond = deployDiamondTest;
