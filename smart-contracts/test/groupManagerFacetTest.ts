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
    } from "../typechain-types";
import { deployDiamond, maxClusterSize, maxGroupsPerIngester, maxIngestersPerGroup } from "../scripts/deploy";
import { IDiamondLoupe } from "../typechain-types/contracts/IngesterOrchestratorDiamond/facets/DiamondLoupeFacet";

import { ethers } from "hardhat";

import { BigNumber } from "ethers";
import { assert, expect } from "chai";
import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";

interface IngesterControllerMapping {
    [ingesterAddress: string]: SignerWithAddress;
}

interface IngesterToGroups {
    [ingesterAddress: string]: string[];
  }

async function addFacetsToDiamond(addresses: string[], diamondCutFacet: DiamondCutFacet, diamondAddress: string, FacetNames: string[]) {
    let accessControlFacet = await ethers.getContractFactory("AccessControlFacet");
    let accessControlFacetSelectors = getSelectors(accessControlFacet);

    let commonFunctionsFacet = await ethers.getContractFactory("CommonFunctionsFacet");
    let commonFunctionSelectors = getSelectors(commonFunctionsFacet);

    FacetNames = [...FacetNames, "AccessControlFacet", "CommonFunctionsFacet"];
    const facetCuts = [];
    let selectorsAdded: any= [];
    for (const FacetName of FacetNames) {
        const Facet = await ethers.getContractFactory(FacetName);
        const facet = await Facet.deploy();
        await facet.deployed();
        addresses.push(facet.address);
        // console.log(`${FacetName} deployed: ${facet.address}`);
        
        let selectorsToAdd = getSelectors(facet);
        if (FacetName != 'AccessControlFacet') {
            let accessControlFacetSelectors = getSelectors(accessControlFacet);
            //filter out AccessControlFacet since all other facets extend this
            selectorsToAdd = selectorsToAdd.filter(
                (selector: any) => !accessControlFacetSelectors.includes(selector)
                );
        }
        if (FacetName != 'CommonFunctionsFacet') {
            let commonFunctionSelectors = getSelectors(commonFunctionsFacet);
            // filter out Common Functions Facet since all other facets extend this
            selectorsToAdd = selectorsToAdd.filter(
                (selector: any) => !commonFunctionSelectors.includes(selector)
                );
        }
        selectorsAdded.push(...selectorsToAdd);
        facetCuts.push({
            facetAddress: facet.address,
            action: FacetCutAction.Add,
            functionSelectors: selectorsToAdd,
        });
    }
    // let diff = selectorsAdded.filter((facet) => !defaultFacets.includes(facet));

    let txDiamond = await diamondCutFacet.diamondCut(
        facetCuts,
        ethers.constants.AddressZero,
        "0x",
        { gasLimit: 30000000 }
    );
    let receiptTx = await txDiamond.wait();
    if (!receiptTx.status) {
        throw Error(`Diamond upgrade failed: ${txDiamond.hash}`);
    }

    return addresses;
}

async function checkClusterIsWithinConstraints(groupManagerFacet: GroupManagerFacet, registryFacet: RegistryFacet) {
    //check each cluster is within constraints
    let clusterIds = await groupManagerFacet.getClusters();
    let getMaxGroupsPerIngester = BigNumber.from(await groupManagerFacet.getMaxGroupsPerIngester()).toNumber();
    for (let i = 0; i < clusterIds.length; i++) {
        let cluster = await groupManagerFacet.getCluster(clusterIds[i]);

        //Calculate the inner cluster contraint for this particular cluster
        let clusterGroupCount = BigNumber.from(cluster.clusterGroupCount).toNumber();
        let maxGroupsPerIngesterWithinCluster = Math.ceil((clusterGroupCount + cluster.ingesterAddresses.length -1) / cluster.ingesterAddresses.length);
        
        let ingesterToGroup: IngesterToGroups = {};
        let clusterGroups: string[] = []
        for (let j = 0; j < cluster.ingesterAddresses.length; j++ ) {
            let ingester = await registryFacet.getIngesterWithGroups(cluster.ingesterAddresses[j]);
            ingesterToGroup[ingester.ingesterAddress] = ingester.assignedGroups;
            clusterGroups = clusterGroups.concat(ingester.assignedGroups);
            
            for (let z = 0; z < ingester.assignedGroups.length; z++){
                let group = await groupManagerFacet.getGroup(ingester.assignedGroups[z]);
                expect(group.ingesterAddresses).includes(cluster.ingesterAddresses[j]);
            } 
            expect(ingester.assignedGroups.length <= maxGroupsPerIngesterWithinCluster);
        }
        
        let maxNumberIngesterPerGroup = BigNumber.from(await groupManagerFacet.getMaxIngestersPerGroup()).toNumber();
        for (let j = 0; j < clusterGroups.length; j++ ) {
            let group = await groupManagerFacet.getGroup(clusterGroups[j]);
            expect(group.ingesterAddresses.length <= maxNumberIngesterPerGroup);
        }
        //check that the amount of addresses per group abides by the global constraint
        expect(cluster.ingesterAddresses.length < maxClusterSize);
        //Check that the amount of groups is lower than the global constraint
        expect(clusterGroups.length < getMaxGroupsPerIngester);
    }

}

async function getClusterMaxGroupsPerIngester(groupManagerFacet: GroupManagerFacet, clusterId: number) {
    let clusterDetails = await groupManagerFacet.getCluster(clusterId);
    let clusterGroupCount = BigNumber.from(clusterDetails.clusterGroupCount).toNumber();
    let clusterIngesterCount = BigNumber.from(clusterDetails.ingesterAddresses.length).toNumber();
    let maxGroupsPerIngesterAfterUnregistering = (clusterGroupCount + clusterIngesterCount - 1) / clusterIngesterCount;
    return maxGroupsPerIngesterAfterUnregistering
}


describe("Testing Group Manager", async function () {
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
    
    //testing storage variables
    let ingesterToController: IngesterControllerMapping = {}
    let removedIngesterAssignedGroups: string[];
    
    //constants
    const message = "Test message";
    const nonce = 1;
    const maxAllocatableGroups: number = maxClusterSize * maxGroupsPerIngester;
    let numIngesters: number = 3;
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
        addresses = await addFacetsToDiamond(addresses, diamondCutFacet, diamondAddress, facetNames);

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

        // console.log("🚀 ~ file: registryFacetTest.ts:326 ~ maxAllocatableGroups:", maxAllocatableGroups)
        // for (let i = 0; i < maxAllocatableGroups; i++ ) {
        //     await groupManagerFacet.connect(contractOwner).addGroup(`group${i}`);
        //     const group = await groupManagerFacet.getGroup(`group${i}`);
        //     expect(group.isAdded).to.be.true;
        //     expect(group.ingesterAddresses.length <= maxGroupsPerIngester)
        // }
    });
        
    it("should set maxNumberIngesterPerGroup correctly with deployment", async () => {
        const maxIngesterPerGroupRes = await groupManagerFacet.getMaxIngestersPerGroup();
        expect(maxIngesterPerGroupRes).to.equal(maxIngestersPerGroup);
    });
    
    it("should be able to set a new maxNumberIngesterPerGroup", async () => {
        expect(await groupManagerFacet.connect(contractOwner).setMaxIngestersPerGroup(10)).to.emit(groupManagerFacet, "MaxIngesterPerGroupUpdated");
        let newMaxNumberIngesterPerGroup = BigNumber.from(await groupManagerFacet.getMaxIngestersPerGroup()).toNumber();
        expect(newMaxNumberIngesterPerGroup).to.equal(10);
    });

    it("should be able to set a new setMaxClusterSize", async () => {
        let newMaxClusterSize = 5;
        expect(await groupManagerFacet.connect(contractOwner).setMaxClusterSize(newMaxClusterSize)).to.emit(groupManagerFacet, "MaxClusterSizeUpdated");
        let maxClusterSize = BigNumber.from(await groupManagerFacet.getMaxClusterSize()).toNumber();
        expect(maxClusterSize).to.equal(newMaxClusterSize);
    });

    it("should be able to set a new setMaxGroupsPerIngester", async () => {
        let newMaxGroupsPerIngester = 100;
        expect(await groupManagerFacet.connect(contractOwner).setMaxGroupsPerIngester(newMaxGroupsPerIngester)).to.emit(groupManagerFacet, "MaxGroupsPerIngesterUpdated");
        let maxClusterSize = BigNumber.from(await groupManagerFacet.getMaxGroupsPerIngester()).toNumber();
        expect(maxClusterSize).to.equal(newMaxGroupsPerIngester);
    });

    it("should add a new group", async () => {
        expect(await groupManagerFacet.connect(contractOwner).addGroup("group1")).to.emit(groupManagerFacet, "GroupAdded").withArgs("group1");
        const group = await groupManagerFacet.getGroup("group1");
        let groupUserNameIndex = BigNumber.from(group.groupUsernameIndex).toNumber();
        let groupUsernames = await groupManagerFacet.getGroupUsernameByIndex(groupUserNameIndex);
        expect(group.isAdded).to.be.true;
        expect(groupUsernames == "group1");
    });

    it("should remove an existing group", async () => {
        await groupManagerFacet.connect(contractOwner).addGroup("group1");

        expect(await groupManagerFacet.connect(contractOwner).removeGroup("group1")) //GroupRemovedFromIngester
        .to.emit(groupManagerFacet, "GroupRemovedFromIngester").withArgs(ingesters[0].address, "group1")
        .and.to.emit(groupManagerFacet, "GroupRemoved").withArgs("group1");
        const group = await groupManagerFacet.getGroup("group1");
        expect(group.isAdded).to.be.false;
    });

    it("should distribute to ingesters when groups are added", async () => {
        //each ingester should have at least 33 groups
        // check group assignement are within constraints
        for (let i = 0; i < maxAllocatableGroups; i++) {
            await groupManagerFacet.connect(contractOwner).addGroup(`group${i}`);
            const group = await groupManagerFacet.getGroup(`group${i}`);
            expect(group.isAdded).to.be.true;
            expect(group.ingesterAddresses.length <= maxIngestersPerGroup)
            
        }

        await checkClusterIsWithinConstraints(groupManagerFacet, registryFacet);
    });

    it("should revert when attempting to distribute more groups than the maxCapacity constraints", async () => {
        let clusterIds = await groupManagerFacet.getClusters();
        let getMaxGroupsPerIngester = BigNumber.from(await groupManagerFacet.getMaxGroupsPerIngester()).toNumber();
        let maxClusterSize = BigNumber.from(await groupManagerFacet.getMaxClusterSize()).toNumber();

        let totalGroupsConstraint = clusterIds.length * maxClusterSize * getMaxGroupsPerIngester;
        
        for (let i = 0; i < totalGroupsConstraint; i++) {
            if(totalGroupsConstraint-1 == i) {
                expect(await groupManagerFacet.connect(contractOwner).addGroup(`group${i}`)).to.revertedWith("No more ingesters available to add groups to");
            } else {
                await groupManagerFacet.connect(contractOwner).addGroup(`group${i}`);
                const group = await groupManagerFacet.getGroup(`group${i}`);
                expect(group.isAdded).to.be.true;
                expect(group.ingesterAddresses.length <= maxIngestersPerGroup);
            }    
        }
    });

    it("should re-adjust groups when ingester is removed", async () => {
        // check group assignement are within constraints
        let totalAssignedGroups: string[] = [];
        for (let i = 0; i < maxAllocatableGroups; i++) {
            await groupManagerFacet.connect(contractOwner).addGroup(`group${i}`);
            const group = await groupManagerFacet.getGroup(`group${i}`);
            totalAssignedGroups.push(`group${i}`);
            expect(group.isAdded).to.be.true;
            expect(group.ingesterAddresses.length <= maxIngestersPerGroup);
        }

        let ingesterToRemove = await registryFacet.getIngesterWithGroups(ingesters[0].address);
        let ingestersAllocatedCluster = BigNumber.from(ingesterToRemove.clusterId).toNumber();
        let maxGroupsPerIngesterBeforeUnregistering = await getClusterMaxGroupsPerIngester(groupManagerFacet, ingestersAllocatedCluster);

        let ingesterRemovedAssignedGroups: string[] = ingesterToRemove.assignedGroups;

        await registryFacet.connect(ingesterToController[ingesters[0].address]).unRegisterIngester(ingesters[0].address);
        let unAllocatedGroupsBeforeDistribution = await groupManagerFacet.getUnallocatedGroups();
        console.log("🚀 ~ file: groupManagerFacetTest.ts:306 ~ it ~ unAllocatedGroupsBeforeDistribution:", unAllocatedGroupsBeforeDistribution)
        await groupManagerFacet.distributeUnallocatedGroups();
        let clusterId = BigNumber.from(ingesterToRemove.clusterId).toNumber();
        let maxGroupsPerIngesterAfterUnregistering = await getClusterMaxGroupsPerIngester(groupManagerFacet, clusterId);
        
        expect(maxGroupsPerIngesterAfterUnregistering > maxGroupsPerIngesterBeforeUnregistering);

        //Get the new assigned groups after unregistration
        let totalAssignedGroupsAfterUnregistration: string[] = []
        let remainingIngesters: SignerWithAddress[] = ingesters.slice(1);
        for (let j = 0; j < remainingIngesters.length; j++) {
            let ingester = await registryFacet.getIngesterWithGroups(remainingIngesters[j].address);
            totalAssignedGroupsAfterUnregistration = totalAssignedGroupsAfterUnregistration.concat(ingester.assignedGroups);
            expect(ingester.assignedGroups.length > maxGroupsPerIngesterBeforeUnregistering);
            expect(ingester.assignedGroups.length < maxGroupsPerIngesterAfterUnregistering);
        }
        console.log('totalAssignedGroupsAfterUnregistration', totalAssignedGroupsAfterUnregistration);
        //Grab unallocated groups and check if they are correctly unallocated and don't overlap with allocated groups
        let unAllocatedGroups = await groupManagerFacet.getUnallocatedGroups();
        console.log("🚀 ~ file: groupManagerFacetTest.ts:323 ~ it ~ unAllocatedGroups:", unAllocatedGroups)
        if (unAllocatedGroups.length > 0) {
            const allocatedGroups = totalAssignedGroups.filter(group => !unAllocatedGroups.includes(group));
            
            expect(allocatedGroups.length == totalAssignedGroupsAfterUnregistration.length);
            const allGroupsAreReallocated = allocatedGroups.every(allocatedGroup => {
                return totalAssignedGroupsAfterUnregistration.includes(allocatedGroup)
            });
            const allUnallocatedGroupsAreUnassigned = totalAssignedGroupsAfterUnregistration.every(allocatedGroup => {
                return !unAllocatedGroups.includes(allocatedGroup)
            })
            expect(allGroupsAreReallocated).to.be.true;
            expect(allUnallocatedGroupsAreUnassigned).to.be.true;

        } else {
            //make sure that the removed assigned groups have been re-allocated to the existing ingesters
            const allGroupsAreReallocated = ingesterRemovedAssignedGroups.every(removedGroup => {
                return totalAssignedGroupsAfterUnregistration.includes(removedGroup)
            })
            expect(allGroupsAreReallocated).to.be.true;
        }

        //check if ingester was also removed from the cluster
        let cluster = await groupManagerFacet.getCluster(ingestersAllocatedCluster);
        expect(cluster.ingesterAddresses).not.include(ingesterToRemove.ingesterAddress);
    });

    
});

