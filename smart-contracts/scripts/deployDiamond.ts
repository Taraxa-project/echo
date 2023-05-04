/* global ethers */
/* eslint prefer-const: "off" */

import { ContractReceipt, Transaction } from "ethers";
import { TransactionDescription, TransactionTypes } from "ethers/lib/utils";
import { ethers } from "hardhat";
import { DiamondCutFacet, DiamondInit } from "../typechain-types";
import { getSelectors, FacetCutAction } from "./libraries/diamond";

export let DiamondAddress: string;
export const maxClusterSize = 3;
export const maxGroupsPerIngester = 200;
export const maxIngestersPerGroup = 1;

export async function deployDiamond() {
    const accounts = await ethers.getSigners();
    const contractOwner = accounts[0];

    // deploy DiamondInit
    // DiamondInit provides a function that is called when the diamond is upgraded to initialize state variables
    // Read about how the diamondCut function works here: https://eips.ethereum.org/EIPS/eip-2535#addingreplacingremoving-functions
    const DiamondInit = await ethers.getContractFactory("DiamondInit");
    const diamondInit = await DiamondInit.deploy();
    await diamondInit.deployed();
    
    // deploy facets
    console.log("DiamondInit deployed:", diamondInit.address);
    console.log("");
    console.log("Deploying facets");

    let FacetNames = ["DiamondCutFacet", "DiamondLoupeFacet", "OwnershipFacet", "GroupManagerFacet", "RegistryFacet", "DataGatheringFacet"];
    let SharedFacets = ["AccessControlFacet", "CommonFunctionsFacet"];
    FacetNames = FacetNames.concat(SharedFacets);
    const facetCuts = [];
    for (const FacetName of FacetNames) {
        const Facet = await ethers.getContractFactory(FacetName);
        const facet = await Facet.deploy();
        await facet.deployed();

        console.log(`${FacetName} deployed: ${facet.address}`);
        let selectorsToAdd = getSelectors(facet);
        if (!SharedFacets.includes(FacetName)) {
            for (const sharedFacet of SharedFacets) {
                let sharedFacetContract = await ethers.getContractFactory(sharedFacet);
                let sharedFacetSelectors = getSelectors(sharedFacetContract);
                selectorsToAdd = selectorsToAdd.filter(
                    (selector: any) => !sharedFacetSelectors.includes(selector)
                    );
            }
        }
        facetCuts.push({
        facetAddress: facet.address,
        action: FacetCutAction.Add,
        functionSelectors: selectorsToAdd,
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

    console.log('Diamond deployed:', diamond.address)
    const diamondAddress = diamond.address
    console.log("🚀 ~ file: deployDiamond.ts:81 ~ deployDiamond ~ diamondAddress:", diamondAddress)

    // returning the address of the diamond
    return {diamondAddress, contractOwner};
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
if (require.main === module) {
  deployDiamond()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error(error);
      process.exit(1);
    });
}

exports.deployDiamond = deployDiamond;
