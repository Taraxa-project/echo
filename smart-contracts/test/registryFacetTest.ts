/* global describe it before ethers */

import {
    getSelectors,
    FacetCutAction,
    removeSelectors,
    findAddressPositionInFacets,
    } from "../scripts/libraries/diamond";
import {
    Diamond,
    DiamondCutFacet,
    DiamondLoupeFacet,
    GroupManagerFacet,
    OwnershipFacet,
    RegistryFacet,
    Test1Facet,
    } from "../typechain-types";
import { deployDiamondTest, maxClusterSize, maxIngestersPerGroup } from "../scripts/deployDiamondTest";

import { ethers } from "hardhat";

import { assert, expect } from "chai";
import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";

import {IngesterControllerMapping,
    addFacetsToDiamond,
    addRegistrationFacet,
 } from "./testUtils/testUtils";
import { Interface } from "@ethersproject/abi";
import { BigNumber } from "ethers";

const contractArtifact = require("../artifacts/contracts/facets/RegistryFacet.sol/RegistryFacet.json");
const registryABI = contractArtifact.abi;

const maxClusterSize = 50;
const maxIngestersPerGroup = 1;


describe("Testing Registration Functionalities", async function () {
    let diamondCutFacet: DiamondCutFacet;
    let diamondLoupeFacet: DiamondLoupeFacet;
    let ownershipFacet: OwnershipFacet;
    const addresses: string[] = [];
    let diamondAddress: string;
    let contractOwner: SignerWithAddress;
    let accounts: SignerWithAddress[];
    let controller: SignerWithAddress;
    let controller2: SignerWithAddress;
    let ingester: SignerWithAddress;
    let ingester2: SignerWithAddress;
    let ingester3: SignerWithAddress;
    let registryFacet: RegistryFacet;
    const message = "Test message";
    const nonce = 1;
    let registrationTx: any;

    const verbose = false;

    before(async function () {
        accounts = await ethers.getSigners();
        controller = accounts[0];
        controller2 = accounts[1];
        ingester = accounts[2];
        ingester2 = accounts[3];
        ingester3 = accounts[4];

        const diamonDeployed = await deployDiamondTest(false, maxClusterSize, maxIngestersPerGroup);
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

        registryFacet = await addRegistrationFacet(addresses, diamondCutFacet);

    });
        
    it("Should register an ingester", async function () {
        registryFacet = await ethers.getContractAt("RegistryFacet", diamondAddress);
      
    
        // Generate the signature
        const hash = ethers.utils.solidityKeccak256(["address", "string", "uint256"], [ingester.address, message, nonce]);
        const signature = await controller.signMessage(ethers.utils.arrayify(hash));
    
        // Register ingester
        registrationTx = await registryFacet.registerIngester(ingester.address, message, nonce, signature);
    
        // Verify the registration
        const ingesterData = await registryFacet.getIngester(ingester.address);
        expect(ingesterData.ingesterAddress).to.equal(ingester.address);
        expect(ingesterData.verified).to.equal(true);
    });

    it("should add ingester to cluster when registering a new ingester", async function () {
        let registrationWaited = await registrationTx.wait();
        await expect(registrationTx).to.emit(registryFacet, "UnAllocatedIngesterAdded").withArgs(ingester.address);
    });

    it("should fail registering a new ingester when sig is incorrect", async function () {
        const incorrectMessage = 'bye';

        let hash = await registryFacet.hash(ingester2.address, message, nonce);
        const sig = await controller2.signMessage(ethers.utils.arrayify(hash));

        await expect(registryFacet.connect(controller2).registerIngester(ingester2.address, incorrectMessage, nonce, sig)).to.be.revertedWith("Invalid signature.");
    });

    it("Should allocate an ingester role when registered", async function () {
        let isRegistered = await registryFacet.isRegisteredIngester(ingester.address);
        expect(isRegistered).to.be.true;
    });

    it("should fail when attempting to re-register the same ingester", async function () {
        //Register an ingester
        
        let hash = await registryFacet.hash(ingester.address, message, nonce);
        const sig = await controller.signMessage(ethers.utils.arrayify(hash));
        
        await expect(registryFacet.connect(controller).registerIngester(ingester.address, message, nonce, sig)).to.be.revertedWith("Ingester already registered.");
    });

    it("should fail when attempting to re-register the same ingester with a different controller account", async function () {
        //Register an ingester
        let ingesterRes = await registryFacet.getIngester(ingester.address);
        let hash = await registryFacet.hash(ingester.address, message, nonce);
        
        const sig = await controller2.signMessage(ethers.utils.arrayify(hash));
        
        await expect(registryFacet.connect(controller2).registerIngester(ingester.address, message, nonce, sig)).to.be.revertedWith("Ingester already registered.");
    });

    it("should be able to register multiple ingester accounts under the same controller account", async function () {
        //Register an ingester
        
        let hash2 = await registryFacet.hash(ingester2.address, message, nonce);
        let hash3 = await registryFacet.hash(ingester3.address, message, nonce);
        
        const sig2 = await controller.signMessage(ethers.utils.arrayify(hash2));
        const sig3 = await controller.signMessage(ethers.utils.arrayify(hash3));
        
        //register other ingester accounts under the same controller address
        await expect(registryFacet.connect(controller).registerIngester(ingester2.address, message, nonce, sig2)).to.emit(registryFacet, "IngesterRegistered")
        .withArgs(controller.address, ingester2.address);
        await expect(registryFacet.connect(controller).registerIngester(ingester3.address, message, nonce, sig3)).to.emit(registryFacet, "IngesterRegistered")
        .withArgs(controller.address, ingester3.address);
    });

    it("Should unregister an ingester", async function () {
        registryFacet = await ethers.getContractAt("RegistryFacet", diamondAddress);
        let ingesterToRemove = await registryFacet.getIngesterWithGroups(ingester.address);

        let tx = await registryFacet.unRegisterIngester(ingester.address);

        await expect(tx).to.emit(registryFacet, "IngesterUnRegistered")
            .withArgs(controller.address, ingester.address);
    
        await expect(registryFacet.getIngester(ingester.address)).to.be.revertedWith("Ingester does not exist.");
    });

    it("Should revoke role of ingester when unregistered", async function () {
        registryFacet = await ethers.getContractAt("RegistryFacet", diamondAddress);
        
        let isRegistered = await registryFacet.isRegisteredIngester(ingester.address);
        expect(isRegistered).to.not.false;
    });
});


describe("Testing Registration with pre-populated data", async function () {
    let diamondCutFacet: DiamondCutFacet;
    let diamondLoupeFacet: DiamondLoupeFacet;
    let ownershipFacet: OwnershipFacet;
    let registryFacet: RegistryFacet;
    let groupManagerFacet: GroupManagerFacet;
    let diamond: Diamond;
    let diamondAddress: string;
    let contractOwner: SignerWithAddress;
    let addresses: string[] = [];
    let ingesterToController: IngesterControllerMapping = {}
    let accounts: SignerWithAddress[] = [];
    let numIngesters = 2;
    let ingesters: SignerWithAddress[] = [];
    const message = "Test message";
    const nonce = 1;
    const maxAllocatableGroups: number = numIngesters * maxClusterSize;

    const verbose = false;
    
    beforeEach(async function () {
        accounts = await ethers.getSigners();

        const diamonDeployed = await deployDiamondTest(false, maxClusterSize, maxIngestersPerGroup);
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

        let facetNames = ['RegistryFacet', 'GroupManagerFacet'];
        let sharedFacets = ["AccessControlFacet", "CommonFunctionsFacet"];
        addresses = await addFacetsToDiamond(addresses, diamondCutFacet, diamondAddress, facetNames, sharedFacets);

        registryFacet = await ethers.getContractAt('RegistryFacet', diamondAddress);
        groupManagerFacet = await ethers.getContractAt('GroupManagerFacet', diamondAddress);

        ingesters = [];
        for (let i = 0; i < maxAllocatableGroups; i++ ) {
            await groupManagerFacet.connect(contractOwner).addGroup(`group${i}`);
            const group = await groupManagerFacet.getGroup(`group${i}`);
            expect(group.isAdded).to.be.true;
            expect(group.ingesterAddresses.length <= maxIngestersPerGroup)
        }

   
    });

    it("should add registered ingester to unAllocatedIngesters if there is not enough groups to monitor", async () => {
        let maxAmountOfIngesters = maxAllocatableGroups / maxClusterSize;

        for (let i = 1; i < maxAmountOfIngesters + 1; i++ ) {
            let hash = await registryFacet.hash(accounts[i].address, message, nonce);
            const sig = await accounts[i-1].signMessage(ethers.utils.arrayify(hash));
            if (i == maxAmountOfIngesters + 1) {
                let registrationTx = await registryFacet.connect(accounts[i-1]).registerIngester(accounts[i].address, message, nonce, sig);
                await expect(registrationTx).to.emit(registryFacet, "UnAllocatedIngesterAdded").withArgs(accounts[i].address);
                let unAllocatedIngesters = await registryFacet.getUnAllocatedIngesters();
                expect(unAllocatedIngesters.length == 1);
            } else {
                await registryFacet.connect(accounts[i-1]).registerIngester(accounts[i].address, message, nonce, sig);
            }
        }
    });

    it("Should remove ingester from cluster upon ingester unregistration", async function () {
        let currentNumIngesters = 1;
        for (let i = 1; i <= currentNumIngesters; i++ ) {
            let hash = await registryFacet.hash(accounts[i].address, message, nonce);
            const sig = await accounts[i-1].signMessage(ethers.utils.arrayify(hash));
            await registryFacet.connect(accounts[i-1]).registerIngester(accounts[i].address, message, nonce, sig);
            ingesterToController[accounts[i].address] = accounts[i-1];
            ingesters.push(accounts[i]);
        }

        let ingesterToRemove = await registryFacet.getIngesterWithGroups(ingesters[0].address);

        let ingesterAssignedGroups = ingesterToRemove.clusterId;

        let unAllocatedIngesters = await registryFacet.getUnAllocatedIngesters();

        let unregisterTx = await registryFacet.unRegisterIngester(ingesters[0].address);

        await expect(unregisterTx).to.emit(registryFacet, "IngesterRemovedFromCluster")
        .withArgs(ingesterToRemove.clusterId, ingesters[0].address)
    });

    it("Should distribute groups to other unallocated ingester upon unregistration", async function () {
        let clusterCount = await registryFacet.getClusterCount();

        let currentNumIngesters = 3;
        ingesters=[];
        ingesterToController={};
        for (let i = 1; i <= currentNumIngesters; i++ ) {
            let hash = await registryFacet.hash(accounts[i].address, message, nonce);
            const sig = await accounts[i-1].signMessage(ethers.utils.arrayify(hash));
            await registryFacet.connect(accounts[i-1]).registerIngester(accounts[i].address, message, nonce, sig);
            ingesterToController[accounts[i].address] = accounts[i-1];
            ingesters.push(accounts[i]);
        }
        
        let ingesterToRemove = await registryFacet.getIngesterWithGroups(ingesters[0].address);
        let ingesterAssignedGroups = ingesterToRemove.assignedGroups;

        let unAllocatedIngesters = await registryFacet.getUnAllocatedIngesters();
        let ingesterReplacementAddress = unAllocatedIngesters[unAllocatedIngesters.length - 1];

        let unregistrationTx = await registryFacet.unRegisterIngester(ingesters[0].address);

        await expect(unregistrationTx).to.emit(registryFacet, "IngesterRemovedFromCluster")
        .withArgs(ingesterToRemove.clusterId, ingesters[0].address)
        .and.to.emit(registryFacet, "IngesterAddedToCluster")
        .withArgs(ingesterToRemove.clusterId, unAllocatedIngesters[unAllocatedIngesters.length - 1]);

        let ingesterReplacement =  await registryFacet.getIngesterWithGroups(ingesterReplacementAddress);
        assert.sameMembers(ingesterReplacement.assignedGroups, ingesterAssignedGroups);

        let cluster = await registryFacet.getCluster(ingesterToRemove.clusterId);
        assert.sameMembers(cluster.groupUsernames, ingesterReplacement.assignedGroups)
    });
});

describe("Testing Registration with pre-populated data and group duplication", async function () {
    let diamondCutFacet: DiamondCutFacet;
    let diamondLoupeFacet: DiamondLoupeFacet;
    let ownershipFacet: OwnershipFacet;
    let registryFacet: RegistryFacet;
    let groupManagerFacet: GroupManagerFacet;
    let diamond: Diamond;
    let diamondAddress: string;
    let contractOwner: SignerWithAddress;
    let addresses: string[] = [];
    let ingesterToController: IngesterControllerMapping = {}
    let accounts: SignerWithAddress[] = [];
    let numIngesters = 2;
    let ingesters: SignerWithAddress[] = [];
    const message = "Test message";
    const nonce = 1;
    const maxAllocatableGroups: number = numIngesters * maxClusterSize;
    console.log("🚀 ~ file: registryFacetTest.ts:322 ~ maxAllocatableGroups:", maxAllocatableGroups)
    const verbose = false;
    const newMaxIngestersPerGroup = 3;
    let numGroupsWithReplication: number;

    beforeEach(async function () {
        accounts = await ethers.getSigners();

        const diamonDeployed = await deployDiamondTest(true, maxClusterSize, maxIngestersPerGroup);
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

        let facetNames = ['RegistryFacet', 'GroupManagerFacet'];
        let sharedFacets = ["AccessControlFacet", "CommonFunctionsFacet"];
        addresses = await addFacetsToDiamond(addresses, diamondCutFacet, diamondAddress, facetNames, sharedFacets);

        registryFacet = await ethers.getContractAt('RegistryFacet', diamondAddress);
        groupManagerFacet = await ethers.getContractAt('GroupManagerFacet', diamondAddress);

        let numGroupsWithReplication = (maxAllocatableGroups / newMaxIngestersPerGroup);
        // add replication of 3
        await groupManagerFacet.setMaxIngestersPerGroup(newMaxIngestersPerGroup);

        ingesters = [];
        for (let i = 0; i < maxAllocatableGroups; i++ ) {
            await groupManagerFacet.connect(contractOwner).addGroup(`group${i}`);
            const group = await groupManagerFacet.getGroup(`group${i}`);
            expect(group.isAdded).to.be.true;
            expect(group.ingesterAddresses.length <= maxIngestersPerGroup)
        }

   
    });

    it("should have set maxNumberIngesterPerGroup correctly", async () => {
        let newMaxNumberIngesterPerGroup = BigNumber.from(await groupManagerFacet.getMaxIngestersPerGroup()).toNumber();
        expect(newMaxNumberIngesterPerGroup).to.equal(newMaxIngestersPerGroup);
    });

    it("Should distribute groups to other unallocated ingester upon unregistration", async function () {
        //with replication of 3, adding 3 ingesters will result in allocation of two separate clusters
        // unregistering an ingester should trigger one of the replicated ingesters to move to empty cluster post unregistration
        let currentNumIngesters = 3;
        let ingesterIndToRemove = 1;
        ingesters = [];
        ingesterToController = {};
        for (let i = 1; i <= currentNumIngesters; i++ ) {
            let hash = await registryFacet.hash(accounts[i].address, message, nonce);
            const sig = await accounts[i-1].signMessage(ethers.utils.arrayify(hash));
            await registryFacet.connect(accounts[i-1]).registerIngester(accounts[i].address, message, nonce, sig);
            ingesterToController[accounts[i].address] = accounts[i-1];
            ingesters.push(accounts[i]);
        }

        //grab ingester that will replace the unregistered ingester, last element
        let cluster1PreUnregistration = await registryFacet.getCluster(0);
        let ingesterReplacementAddress = cluster1PreUnregistration.ingesterAddresses[cluster1PreUnregistration.ingesterAddresses.length - 1];
        
        //grab ingester that will be unregistered and replaced
        let ingesterToRemoveAddress = ingesters[ingesterIndToRemove].address;
        let ingesterToRemove = await registryFacet.getIngesterWithGroups(ingesterToRemoveAddress);
        let ingesterAssignedGroups = ingesterToRemove.assignedGroups;

        let unregistrationTx = await registryFacet.connect(ingesterToController[ingesterToRemoveAddress]).unRegisterIngester(ingesterToRemoveAddress);

        await expect(unregistrationTx).to.emit(registryFacet, "IngesterRemovedFromCluster")
        .withArgs(ingesterToRemove.clusterId, ingesterToRemoveAddress)
        .and.to.emit(registryFacet, "IngesterAddedToCluster")
        .withArgs(ingesterToRemove.clusterId, ingesterReplacementAddress);

        //check that the ingester replacement has the same groups as the ingester that was removed
        let ingesterReplacement =  await registryFacet.getIngesterWithGroups(ingesterReplacementAddress);
        assert.sameMembers(ingesterReplacement.assignedGroups, ingesterAssignedGroups);

        let cluster1PostUnregistration = await registryFacet.getCluster(0);
        let cluster2PostUnregistration = await registryFacet.getCluster(1);
        expect(cluster1PostUnregistration.ingesterAddresses.length == 1);
        expect(cluster2PostUnregistration.ingesterAddresses.length == 1);
    });

});