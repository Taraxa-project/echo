// test/DiamondUpgrade.test.ts

import { assert, expect } from "chai";
import {
    Diamond,
    DiamondCutFacet,
    DiamondLoupeFacet,
    GroupManagerFacet,
    OwnershipFacet,
    RegistryFacet,
    } from "../typechain-types";
import { ethers } from "hardhat";
import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";
import { deployDiamondTest} from "../scripts/deployDiamondTest";
import {
    addFacetsToDiamond,
    IngesterControllerMapping,
    removeFacetsFromDiamond
 } from "./testUtils/testUtils";
import { BigNumber } from "ethers";


const maxClusterSize = 50;
const maxIngestersPerGroup = 1;

describe("Diamond Upgrade", () => {
  //Diamond related storage
  let diamondCutFacet: DiamondCutFacet;
  let diamondLoupeFacet: DiamondLoupeFacet;
  let ownershipFacet: OwnershipFacet;
  let addresses: string[] = [];
  let diamondAddress: string;
  let registryFacet: RegistryFacet;
  let groupManagerFacet: GroupManagerFacet;

  //accounts
  let contractOwner: SignerWithAddress;
  let accounts: SignerWithAddress[];
  let ingesters: SignerWithAddress[];
  let ingesterToController: IngesterControllerMapping = {}

  //constants
  const message = "Test message";
  const nonce = 1;
  let numIngesters: number = 3;
  const verbose = false;



  beforeEach(async () => {
    // Set up the initial Diamond and its facets (including the initial LibAppStorage and IngesterFacet)
    accounts = await ethers.getSigners();

    const diamonDeployed = await deployDiamondTest(verbose, maxClusterSize, maxIngestersPerGroup);
    diamondAddress = diamonDeployed.diamondAddress;
    contractOwner = diamonDeployed.contractOwner;
    
    diamondCutFacet = await ethers.getContractAt(
        "DiamondCutFacet",
        diamondAddress
    );
    diamondLoupeFacet = await ethers.getContractAt(
        "DiamondLoupeFacet",
        diamondAddress
    );
    ownershipFacet = await ethers.getContractAt(
        "OwnershipFacet",
        diamondAddress
    );
    
    for (const address of await diamondLoupeFacet.facetAddresses()) {
        addresses.push(address);
    }

    let facetNames = ['RegistryFacet', 'GroupManagerFacet', 'DataGatheringFacet'];
    let sharedFacets = ["AccessControlFacet", "CommonFunctionsFacet"];
    addresses = await addFacetsToDiamond(addresses, diamondCutFacet, diamondAddress, facetNames, sharedFacets);

    registryFacet = await ethers.getContractAt('RegistryFacet', diamondAddress);
    groupManagerFacet = await ethers.getContractAt('GroupManagerFacet', diamondAddress);

    let numGroups = 150;
    for (let i = 0; i < numGroups; i++) {
        await groupManagerFacet.connect(contractOwner).addGroup(`group${i}`);
        const group = await groupManagerFacet.getGroup(`group${i}`);
    }

    ingesters = [];
    for (let i = 1; i <= numIngesters; i++ ) {
        let hash = await registryFacet.hash(accounts[i].address, message, nonce);
        const sig = await accounts[i-1].signMessage(ethers.utils.arrayify(hash));
        await registryFacet.connect(accounts[i-1]).registerIngester(accounts[i].address, message, nonce, sig);
        ingesterToController[accounts[i].address] = accounts[i-1];
        ingesters.push(accounts[i]);
    }
  });

  it("upgrades LibAppStorage only with only one facet", async () => {

    // Get the ingester data before the upgrade
    let ingestersBeforeUpgrade = []
    for (let i = 0; i < ingesters.length; i++) {
        const ingesterBeforeUpgrade = await registryFacet.getIngester(ingesters[i].address);
        ingestersBeforeUpgrade.push(ingesterBeforeUpgrade);
        expect(ingesterBeforeUpgrade.verified).to.be.true;
    }

    // Remove the existing facets
    let facetNames: string[] = [];
    let sharedFacets = [ "CommonFunctionsFacet"];
    addresses = await removeFacetsFromDiamond(addresses, diamondCutFacet, diamondAddress, facetNames, sharedFacets)


    //Deploy and add the new facets with the new libAppStorage 
    let newFacetNames: string[] = []
    let newSharedFacets = ["CommonFunctionsFacetTest"]; 
    addresses = await addFacetsToDiamond(addresses, diamondCutFacet, diamondAddress, newFacetNames, newSharedFacets);

    // Check if the new facet has the replaced function
    let newCommonFunctionsFacet = await ethers.getContractAt("CommonFunctionsFacetTest", diamondAddress);

    //Test that ingesters storage before update has persisted
    let ingesterCount = await newCommonFunctionsFacet.getIngesterCount();
    assert.strictEqual(BigNumber.from(ingesterCount).toNumber(), ingesters.length);

    // new ingesters() function only returns one ingester instead of all the ingesters
    let newIngestersRes = await newCommonFunctionsFacet.getIngesters();
    assert.strictEqual(newIngestersRes.length, 1);

    await newCommonFunctionsFacet.setTestProperty(true);
    let newTestProperty = await newCommonFunctionsFacet.getTestProperty();
    assert.isTrue(newTestProperty);

    // Check that the new LibAppStorage is being used and any related state changes
    // Check that ingester data is still the same after upgrade
    let ingestersAfterUpgrade = []
    for (let i = 0; i < ingesters.length; i++) {
        const ingesterAfterUpgrade = await newCommonFunctionsFacet.getIngester(ingesters[i].address);
        ingestersAfterUpgrade.push(ingesterAfterUpgrade);
        expect(ingesterAfterUpgrade.verified).to.be.true;
    }
    assert.sameDeepMembers(ingestersAfterUpgrade, ingestersBeforeUpgrade);
  });

  it("upgrades LibAppStorage only with partial facets", async () => {

    // Get the ingester data before the upgrade
    let ingestersBeforeUpgrade = []
    for (let i = 0; i < ingesters.length; i++) {
        const ingesterBeforeUpgrade = await registryFacet.getIngester(ingesters[i].address);
        ingestersBeforeUpgrade.push(ingesterBeforeUpgrade);
        expect(ingesterBeforeUpgrade.verified).to.be.true;
    }

    // Remove the existing facets
    let facetNames: string[] = [];
    let sharedFacets = [ "AccessControlFacet", "CommonFunctionsFacet"];
    addresses = await removeFacetsFromDiamond(addresses, diamondCutFacet, diamondAddress, facetNames, sharedFacets)


    //Deploy and add the new facets with the new libAppStorage 
    let newFacetNames: string[] = []
    let newSharedFacets = ["AccessControlFacetTest", "CommonFunctionsFacetTest"];  
    addresses = await addFacetsToDiamond(addresses, diamondCutFacet, diamondAddress, newFacetNames, newSharedFacets);

    // Check if the new facet has the replaced function
    let newCommonFunctionsFacet = await ethers.getContractAt("CommonFunctionsFacetTest", diamondAddress);

    //Test that ingesters storage before update has persisted
    let ingesterCount = await newCommonFunctionsFacet.getIngesterCount();
    assert.strictEqual(BigNumber.from(ingesterCount).toNumber(), ingesters.length);

    // new ingesters() function only returns one ingester instead of all the ingesters
    let newIngestersRes = await newCommonFunctionsFacet.getIngesters();
    assert.strictEqual(newIngestersRes.length, 1);

    await newCommonFunctionsFacet.setTestProperty(true);
    let newTestProperty = await newCommonFunctionsFacet.getTestProperty();
    assert.isTrue(newTestProperty);

    // Check that the new LibAppStorage is being used and any related state changes
    // Check that ingester data is still the same after upgrade
    let ingestersAfterUpgrade = []
    for (let i = 0; i < ingesters.length; i++) {
        const ingesterAfterUpgrade = await newCommonFunctionsFacet.getIngester(ingesters[i].address);
        ingestersAfterUpgrade.push(ingesterAfterUpgrade);
        expect(ingesterAfterUpgrade.verified).to.be.true;
    }
    assert.sameDeepMembers(ingestersAfterUpgrade, ingestersBeforeUpgrade);
  });

  it("upgrades LibAppStorage and retains ingester data", async () => {

    // Get the ingester data before the upgrade
    let ingestersBeforeUpgrade = []
    for (let i = 0; i < ingesters.length; i++) {
        const ingesterBeforeUpgrade = await registryFacet.getIngester(ingesters[i].address);
        ingestersBeforeUpgrade.push(ingesterBeforeUpgrade);
        expect(ingesterBeforeUpgrade.verified).to.be.true;
    }

    // Remove the existing facets
    let facetNames = ["GroupManagerFacet", "RegistryFacet", "DataGatheringFacet"];
    let sharedFacets = ["AccessControlFacet", "CommonFunctionsFacet"];
    addresses = await removeFacetsFromDiamond(addresses, diamondCutFacet, diamondAddress, facetNames, sharedFacets)


    //Deploy and add the new facets with the new libAppStorage 
    let newFacetNames = ["GroupManagerFacetTest", "RegistryFacetTest", "DataGatheringFacetTest"];
    let newSharedFacets = ["AccessControlFacetTest", "CommonFunctionsFacetTest"];
    addresses = await addFacetsToDiamond(addresses, diamondCutFacet, diamondAddress, newFacetNames, newSharedFacets);
   
    // Check if the new facet has the replaced function
    let newCommonFunctionsFacet = await ethers.getContractAt("CommonFunctionsFacetTest", diamondAddress);

    //Test that ingesters storage before update has persisted
    let ingesterCount = await newCommonFunctionsFacet.getIngesterCount();
    assert.strictEqual(BigNumber.from(ingesterCount).toNumber(), ingesters.length);

    // new ingesters() function only returns one ingester instead of all the ingesters
    let newIngestersRes = await newCommonFunctionsFacet.getIngesters();
    assert.strictEqual(newIngestersRes.length, 1);

    await newCommonFunctionsFacet.setTestProperty(true);
    let newTestProperty = await newCommonFunctionsFacet.getTestProperty();
    assert.isTrue(newTestProperty);


    // Check that the new LibAppStorage is being used and any related state changes
    // Check that ingester data is still the same after upgrade
    let ingestersAfterUpgrade = []
    for (let i = 0; i < ingesters.length; i++) {
        const ingesterAfterUpgrade = await newCommonFunctionsFacet.getIngester(ingesters[i].address);
        ingestersAfterUpgrade.push(ingesterAfterUpgrade);
        expect(ingesterAfterUpgrade.verified).to.be.true;
    }
    assert.sameDeepMembers(ingestersAfterUpgrade, ingestersBeforeUpgrade);

});

});

