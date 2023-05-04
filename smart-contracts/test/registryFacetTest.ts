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
import { deployDiamond, maxClusterSize, maxGroupsPerIngester, maxIngestersPerGroup } from "../scripts/deploy";

import { ethers } from "hardhat";

import { assert, expect } from "chai";
import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";

import {IngesterControllerMapping,
    addFacetsToDiamond,
    addRegistrationFacet,
 } from "./testUtils/testUtils";


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
    let removedIngesterAssignedGroups: string[];
    const message = "Test message";
    const nonce = 1;
    let registrationTx: any;
    const maxAllocatableGroups: number = maxClusterSize * maxGroupsPerIngester;

    const verbose = false;

    before(async function () {
        accounts = await ethers.getSigners();
        controller = accounts[0];
        controller2 = accounts[1];
        ingester = accounts[2];
        ingester2 = accounts[3];
        ingester3 = accounts[4];

        const diamonDeployed = await deployDiamond(verbose);
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
        expect(registrationTx).to.emit(registryFacet, "IngesterAddedToCluster").withArgs(ingester.address, 0);
    });

    it("should fail registering a new ingester when sig is incorrect", async function () {
        const incorrectMessage = 'bye';

        let hash = await registryFacet.hash(ingester.address, message, nonce);
        const sig = await controller.signMessage(ethers.utils.arrayify(hash));

        expect(registryFacet.connect(controller).registerIngester(ingester.address, incorrectMessage, nonce, sig)).to.be.revertedWith("Invalid signature.");
    });

    it("Should allocate an ingester role when registered", async function () {
        let isRegistered = await registryFacet.isRegisteredIngester(ingester.address);
        expect(isRegistered).to.be.true;
    });

    it("should fail when attempting to re-register the same ingester", async function () {
        //Register an ingester
        
        let hash = await registryFacet.hash(ingester.address, message, nonce);
        const sig = await controller.signMessage(ethers.utils.arrayify(hash));
        
        expect(registryFacet.connect(controller).registerIngester(ingester.address, message, nonce, sig)).to.be.revertedWith("Ingester already registered.");
    });

    it("should fail when attempting to re-register the same ingester with a different controller account", async function () {
        //Register an ingester
        let hash = await registryFacet.hash(ingester.address, message, nonce);
        
        const sig = await controller.signMessage(ethers.utils.arrayify(hash));
        
        expect(registryFacet.connect(controller2).registerIngester(ingester.address, message, nonce, sig)).to.be.revertedWith("Ingestor already registered.");
    });

    it("should be able to register multiple ingester accounts under the same controller account", async function () {
        //Register an ingester
        
        let hash = await registryFacet.hash(ingester.address, message, nonce);
        
        const sig = await controller.signMessage(ethers.utils.arrayify(hash));
        
        expect(registryFacet.connect(controller).registerIngester(ingester.address, message, nonce, sig)).to.emit(registryFacet, "IngesterRegistered")
        .withArgs(ingester.address, controller.address);

        //register other ingester accounts under the same controller address
        expect(registryFacet.connect(controller).registerIngester(ingester2.address, message, nonce, sig)).to.emit(registryFacet, "IngesterRegistered")
        .withArgs(ingester2.address, controller.address);
        expect(registryFacet.connect(controller).registerIngester(ingester3.address, message, nonce, sig)).to.emit(registryFacet, "IngesterRegistered")
        .withArgs(ingester3.address, controller.address);
    });

    it("Should unregister an ingester", async function () {
        registryFacet = await ethers.getContractAt("RegistryFacet", diamondAddress);
        let ingesterToRemove = await registryFacet.getIngesterWithGroups(ingester.address);
        removedIngesterAssignedGroups = ingesterToRemove.assignedGroups;

        let tx = await registryFacet.unRegisterIngester(ingester.address);
        let txUnregister = await tx.wait();

        expect(txUnregister).to.emit(diamondAddress, "IngesterUnRegistered")
            .withArgs(controller.address, ingester.address)
            .and.to.emit(diamondAddress, "IngesterRemovedFromGroup")
            .withArgs(ingester.address, ingesterToRemove.assignedGroups);
    
        expect(registryFacet.getIngester(ingester.address)).to.be.revertedWith("Ingester does not exist.");
    });

    it("Should revoke role of ingester when unregistered", async function () {
        registryFacet = await ethers.getContractAt("RegistryFacet", diamondAddress);
        
        let isRegistered = await registryFacet.isRegisteredIngester(ingester.address);
        expect(isRegistered).to.not.false;
    });

    it("should add ingester to additional cluster when more than maxClusterSize is reached", async function () {
        //Register an ingester
        let numIngesters = 3;
        let currentClusterCount = 0;

        for (let i = 1; i <= numIngesters; i++ ) {
            let hash = await registryFacet.hash(accounts[i].address, message, nonce);
            const sig = await controller2.signMessage(ethers.utils.arrayify(hash));
            if (i <= maxClusterSize) {
                expect(await registryFacet.connect(controller2).registerIngester(accounts[i].address, message, nonce, sig)).to.emit(registryFacet, "IngesterAddedToCluster").withArgs(accounts[i].address, currentClusterCount);
            } else {
                //increment cluster count
                i == maxClusterSize + 1 && currentClusterCount++;
                expect(await registryFacet.connect(controller2).registerIngester(accounts[i].address, message, nonce, sig)).to.emit(registryFacet, "IngesterAddedToCluster").withArgs(accounts[i].address, currentClusterCount);
            }
        }
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
    let numIngesters = 3;
    let ingesters: SignerWithAddress[] = [];
    const message = "Test message";
    const nonce = 1;
    const maxAllocatableGroups: number = maxClusterSize * maxGroupsPerIngester;

    const verbose = false;
    
    beforeEach(async function () {
        accounts = await ethers.getSigners();

        const diamonDeployed = await deployDiamond(verbose);
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

        for (let i = 1; i <= numIngesters; i++ ) {
            let hash = await registryFacet.hash(accounts[i].address, message, nonce);
            const sig = await accounts[i-1].signMessage(ethers.utils.arrayify(hash));
            await registryFacet.connect(accounts[i-1]).registerIngester(accounts[i].address, message, nonce, sig);
            ingesterToController[accounts[i].address] = accounts[i-1];
            ingesters.push(accounts[i]);
        }

        console.log("🚀 ~ file: registryFacetTest.ts:326 ~ maxAllocatableGroups:", maxAllocatableGroups)
        for (let i = 0; i < maxAllocatableGroups; i++ ) {
            await groupManagerFacet.connect(contractOwner).addGroup(`group${i}`);
            const group = await groupManagerFacet.getGroup(`group${i}`);
            expect(group.isAdded).to.be.true;
            expect(group.ingesterAddresses.length <= maxGroupsPerIngester)
        }
    });

    it("Should add to unAllocatedGroups upon ingester unregistration", async function () {
        let ingesterToRemove = await registryFacet.getIngesterWithGroups(ingesters[0].address);

        let ingesterAssignedGroups = ingesterToRemove.assignedGroups;

        await registryFacet.unRegisterIngester(ingesters[0].address);

        let unAllocatedGroups = await registryFacet.getUnallocatedGroups();
        expect(unAllocatedGroups.length == ingesterAssignedGroups.length);
        assert.sameMembers(unAllocatedGroups, ingesterAssignedGroups);
    });

    it("Should distribute groups to other ingester upon unregistration", async function () {
        let ingesterToRemove = await registryFacet.getIngesterWithGroups(ingesters[0].address);

        let ingesterAssignedGroups = ingesterToRemove.assignedGroups;

        await registryFacet.unRegisterIngester(ingesters[0].address);

        let tx = await groupManagerFacet.distributeUnallocatedGroups();
        let txDistribution = tx.wait();

        let unAllocatedGroups = await registryFacet.getUnallocatedGroups();

        expect(unAllocatedGroups.length == 0);

        let groupsDistributed: string[] = [];
        for (let i = 0; i < ingesterAssignedGroups.length; i++) {
            let groupName = ingesterAssignedGroups[i];
            expect(txDistribution).to.emit(groupManagerFacet,"RemoveUnallocatedGroup").withArgs(groupName);

            let group  = await groupManagerFacet.getGroup(groupName);
            expect(group.isAdded).to.be.true;
            for( let j = 0; j < group.ingesterAddresses.length; j++) {
                let ingester = await registryFacet.getIngesterWithGroups(group.ingesterAddresses[j]);
                expect(ingester.assignedGroups).to.include(groupName);
            }
        }
    });
});