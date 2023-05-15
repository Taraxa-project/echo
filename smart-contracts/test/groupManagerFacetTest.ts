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
import { deployDiamondTest, maxClusterSize, maxGroupsPerIngester, maxIngestersPerGroup } from "../scripts/deployDiamondTest";
import { IDiamondLoupe } from "../typechain-types/contracts/IngesterOrchestratorDiamond/facets/DiamondLoupeFacet";

import { ethers } from "hardhat";

import { BigNumber } from "ethers";
import { assert, expect } from "chai";
import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";

import {IngesterControllerMapping,
    IngesterToGroups,
    allUnique,
    addFacetsToDiamond,
    checkClusterIsWithinConstraints,
    getClusterMaxGroupsPerIngester
 } from "./testUtils/testUtils";
import { group } from "console";
import { deployDiamond } from "../scripts/deployDiamond";

function assertAllEqual(array: number[]) {
    if (array.length > 0) {
        const first = array[0];
        for (const item of array) {
            assert.equal(first, item, "Not all items in the array are equal");
        }
    }
}

function assertAllSameLength(array: string[][]) {
    if (array.length > 0) {
        const firstLength = array[0].length;
        for (const subArray of array) {
            assert.equal(firstLength, subArray.length, "Not all arrays have the same length");
        }
    }
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
    let numIngesters: number = 3;
    const maxAllocatableGroups: number = numIngesters * maxGroupsPerIngester;
    console.log("🚀 ~ file: groupManagerFacetTest.ts:59 ~ maxAllocatableGroups:", maxAllocatableGroups)
    const numIngestersToRemove = 2;
    const verbose = false;

    beforeEach(async function () {
        accounts = await ethers.getSigners();

        const diamonDeployed = await deployDiamondTest();
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

        // for (let i = 1; i <= numIngesters; i++ ) {
        //     let hash = await registryFacet.hash(accounts[i].address, message, nonce);
        //     const sig = await accounts[i-1].signMessage(ethers.utils.arrayify(hash));
        //     await registryFacet.connect(accounts[i-1]).registerIngester(accounts[i].address, message, nonce, sig);
        //     ingesterToController[accounts[i].address] = accounts[i-1];
        //     ingesters.push(accounts[i]);
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

        expect(await groupManagerFacet.connect(contractOwner).removeGroup("group1"))
        .and.to.emit(groupManagerFacet, "GroupRemoved").withArgs("group1")
        .and.to.emit(groupManagerFacet, "GroupRemovedFromCluster").withArgs(0, "group1");
        const group = await groupManagerFacet.getGroup("group1");
        expect(group.isAdded).to.be.false;
    });

    it("should add and remove all groups", async () => {

        for (let i = 0; i < maxAllocatableGroups; i++) {
            await groupManagerFacet.connect(contractOwner).addGroup(`group${i}`);
            const group = await groupManagerFacet.getGroup(`group${i}`);
            expect(group.isAdded).to.be.true;
            expect(group.ingesterAddresses.length <= maxIngestersPerGroup)
        }
        
        let clusters = await groupManagerFacet.getClusters();
        
        for (let i = 0; i < maxAllocatableGroups; i++) {
            await groupManagerFacet.connect(contractOwner).removeGroup(`group${i}`);
            const group = await groupManagerFacet.getGroup(`group${i}`);
            expect(group.isAdded).to.be.false;
            expect(group.ingesterAddresses.length <= maxIngestersPerGroup)
        }

        let inactiveClusters = await groupManagerFacet.getInActiveClusters();
        expect(inactiveClusters.length == clusters.length);
    });

    it("should create new group clusters when maxGroupsPerIngester is exceeded" , async () => {
        let numClusters = Math.round(maxAllocatableGroups / maxGroupsPerIngester);
        for (let i = 0; i < maxAllocatableGroups; i++) {
            await groupManagerFacet.connect(contractOwner).addGroup(`group${i}`);
            const group = await groupManagerFacet.getGroup(`group${i}`);
            expect(group.isAdded).to.be.true;
            expect(group.ingesterAddresses.length <= maxIngestersPerGroup)
            
        }
        let clusterCount = await groupManagerFacet.getClusterCount();
        expect(BigNumber.from(clusterCount).toNumber() == numClusters);
        let clusters = await groupManagerFacet.getClusters();
        let groupCounts = []
        for (const cluster of clusters) {
            let clusterDetails = await groupManagerFacet.getCluster(cluster);
            groupCounts.push(BigNumber.from(clusterDetails.groupCount).toNumber());
        }
        assertAllEqual(groupCounts);
    });

    it("should distribute to ingesters when groups are added", async () => {
        for (let i = 0; i < maxAllocatableGroups; i++) {
            await groupManagerFacet.connect(contractOwner).addGroup(`group${i}`);
            const group = await groupManagerFacet.getGroup(`group${i}`);
            expect(group.isAdded).to.be.true;
            expect(group.ingesterAddresses.length <= maxIngestersPerGroup)
        }

        ingesters = [];
        let ingestersAssignedGroups = []
        for (let i = 1; i <= numIngesters; i++ ) {
            let hash = await registryFacet.hash(accounts[i].address, message, nonce);
            const sig = await accounts[i-1].signMessage(ethers.utils.arrayify(hash));
            await registryFacet.connect(accounts[i-1]).registerIngester(accounts[i].address, message, nonce, sig);
            ingesterToController[accounts[i].address] = accounts[i-1];
            ingesters.push(accounts[i]);
            let ingester = await registryFacet.getIngesterWithGroups(accounts[i].address);
            ingestersAssignedGroups.push(ingester.assignedGroups);
        }

        assertAllSameLength(ingestersAssignedGroups);
    });

    it("should trigger event ClusterHasNoIngesters when ingester is removed and no more available ingesters are available", async () => {
        //take half of the total allocatable groups so there is space in the cluster to re-allocate for this test
        for (let i = 0; i < maxAllocatableGroups; i++) {
            await groupManagerFacet.connect(contractOwner).addGroup(`group${i}`);
            const group = await groupManagerFacet.getGroup(`group${i}`);
        }

        for (let i = 1; i <= numIngesters; i++ ) {
            let hash = await registryFacet.hash(accounts[i].address, message, nonce);
            const sig = await accounts[i-1].signMessage(ethers.utils.arrayify(hash));
            await registryFacet.connect(accounts[i-1]).registerIngester(accounts[i].address, message, nonce, sig);
        }

        let ingesterToRemove = await registryFacet.getIngesterWithGroups(accounts[1].address);
        let ingesterClusterId = BigNumber.from(ingesterToRemove.clusterId).toNumber();
        
        let unregistrationTx = await registryFacet.unRegisterIngester(accounts[1].address);

        await expect(unregistrationTx).to.emit(registryFacet, "ClusterHasNoIngesters").withArgs(ingesterClusterId);

        let cluster = await registryFacet.getCluster(ingesterClusterId);
        console.log("🚀 ~ file: groupManagerFacetTest.ts:267 ~ it ~ cluster:", cluster)
        expect(cluster.ingesterAddresses.length == 0);
    });

    it("should allocate unAllocated ingester when available to newly added Groups", async () => {

        // use last available account as new test ingester to be registered
        let hash = await registryFacet.hash(accounts[1].address, message, nonce);
        const sig = await accounts[0].signMessage(ethers.utils.arrayify(hash));
        let registrationTx = await registryFacet.connect(accounts[0]).registerIngester(accounts[1].address, message, nonce, sig);

        await expect(registrationTx).to.emit(registryFacet, "UnAllocatedIngesterAdded").withArgs(accounts[1].address);
        
        let groupsAdded = [];
        for (let i = 0; i < maxGroupsPerIngester; i++) {
            let groupTx = await groupManagerFacet.connect(contractOwner).addGroup(`group${i}`);
            if ( i == 0){
                await expect(groupTx).to.emit(groupManagerFacet, "IngesterAddedToCluster").withArgs(accounts[1].address, 0);
                let cluster = await registryFacet.getCluster(0);
                expect(cluster.ingesterAddresses).to.include(accounts[1].address);
            }
            const group = await groupManagerFacet.getGroup(`group${i}`);
            expect(group.isAdded).to.be.true;
            console.log("🚀 ~ file: groupManagerFacetTest.ts:274 ~ it ~ group.ingesterAddresses.length:", group.ingesterAddresses.length)
            expect(group.ingesterAddresses.length <= maxIngestersPerGroup);
            groupsAdded.push(`group${i}`);

        }

        let ingester = await registryFacet.getIngesterWithGroups(accounts[1].address);
        console.log("🚀 ~ file: groupManagerFacetTest.ts:277 ~ it ~ ingester:", ingester);
        console.log("🚀 ~ file: groupManagerFacetTest.ts:294 ~ it ~ groupsAdded:", groupsAdded)
        assert.sameMembers(groupsAdded, ingester.assignedGroups);
    });

    it("should add unaloccated groups to newly registered ingester if capacity allows", async () => {

        // should add 2 clusters full
        //register two ingesters which will take a cluster each
        //unregister an ingester, making one of the clusters unmonitored
        //re-register an ingester and see if the newly registered ingester gets allocated to the unallocated groups/cluster
        let ingesterCount = 2;

        let maxTwoGroupsGroups = ingesterCount * maxGroupsPerIngester;

        // Add maximum groups possible
        let totalAssignedGroups: string[] = [];
        for (let i = 0; i < maxTwoGroupsGroups; i++) {
            await groupManagerFacet.connect(contractOwner).addGroup(`group${i}`);
            const group = await groupManagerFacet.getGroup(`group${i}`);
            totalAssignedGroups.push(`group${i}`);
            expect(group.isAdded).to.be.true;
            expect(group.ingesterAddresses.length <= maxIngestersPerGroup)
        }
        //register two ingesters
        for (let i = 1; i <= ingesterCount; i++ ) {
            let hash = await registryFacet.hash(accounts[i].address, message, nonce);
            const sig = await accounts[i-1].signMessage(ethers.utils.arrayify(hash));
            await registryFacet.connect(accounts[i-1]).registerIngester(accounts[i].address, message, nonce, sig);
            ingesterToController[accounts[i].address] = accounts[i-1];
            ingesters.push(accounts[i]);
        }

        let ingesterToRemove1 = await groupManagerFacet.getIngesterWithGroups(ingesters[0].address);
        console.log("🚀 ~ file: groupManagerFacetTest.ts:318 ~ it ~ ingesterToRemove1:", ingesterToRemove1)
        let ingesterRemovedAssignedGroups1: string[] = ingesterToRemove1.assignedGroups;

        let ingesterToRemove2 = await groupManagerFacet.getIngesterWithGroups(ingesters[1].address);
        console.log("🚀 ~ file: groupManagerFacetTest.ts:321 ~ it ~ ingesterToRemove2:", ingesterToRemove2)
        let ingesterRemovedAssignedGroups2: string[] = ingesterToRemove2.assignedGroups;

        let unregistrationTx = await registryFacet.connect(ingesterToController[ingesters[1].address]).unRegisterIngester(ingesters[1].address);

        await expect(unregistrationTx).to.emit(registryFacet, "ClusterHasNoIngesters").withArgs(1);

        let cluster2AfterUnregistration = await registryFacet.getCluster(1);
        expect( cluster2AfterUnregistration.ingesterAddresses.length == 0);

        //register second ingester again to take the unmonitored groups
        let hash = await registryFacet.hash(ingesters[1].address, message, nonce);
        const sig = await ingesterToController[ingesters[1].address].signMessage(ethers.utils.arrayify(hash));
        await registryFacet.connect(ingesterToController[ingesters[1].address]).registerIngester(ingesters[1].address, message, nonce, sig);        
        
        let ingester2 = await registryFacet.getIngesterWithGroups(ingesters[1].address);

        let cluster2AfteRegistration = await registryFacet.getCluster(1);
        assert.sameMembers(ingester2.assignedGroups, cluster2AfteRegistration.groupUsernames);
        
    });

    // describe("Manage Groups With Replication", function () {
    //     const newMaxIngestersPerGroup = 3;

    //     let numGroupsWithReplication: number;
    //     beforeEach(async function () {
    //         numGroupsWithReplication = (maxAllocatableGroups / newMaxIngestersPerGroup);
    //         // add replication of 3
    //         await groupManagerFacet.setMaxIngestersPerGroup(newMaxIngestersPerGroup);
    //     });

    //     it("should have set maxNumberIngesterPerGroup correctly", async () => {
    //         let newMaxNumberIngesterPerGroup = BigNumber.from(await groupManagerFacet.getMaxIngestersPerGroup()).toNumber();
    //         expect(newMaxNumberIngesterPerGroup).to.equal(newMaxIngestersPerGroup);
    //     });
    
    //     it("should add a new group to all ingesters within cluster", async () => {
    //         let addGroupTx = await groupManagerFacet.connect(contractOwner).addGroup("group1");
    //         const group = await groupManagerFacet.getGroup("group1");
    //         let groupUserNameIndex = BigNumber.from(group.groupUsernameIndex).toNumber();
    //         let groupUsernames = await groupManagerFacet.getGroupUsernameByIndex(groupUserNameIndex);
    //         expect(addGroupTx).to.emit(groupManagerFacet, "GroupDistributed").withArgs(group.clusterId, "group1")
    //             .and.to.emit(groupManagerFacet, "GroupAdded").withArgs("group1");
    //         expect(group.isAdded).to.be.true;
    //         expect(groupUsernames == "group1");
            
    //         expect(group.ingesterAddresses.length == newMaxIngestersPerGroup);
            
    //         //check groups have been added to all ingesters
    //         for (let i = 0; i < group.ingesterAddresses.length; i++) {
    //             let ingester = await groupManagerFacet.getIngesterWithGroups(group.ingesterAddresses[i]);
    //             expect(ingester.assignedGroups).to.include("group1");
    //         }

    //     });

    //     it("should remove an existing group", async () => {
    //         await groupManagerFacet.connect(contractOwner).addGroup("group1");
    //         const groupAfterAddition = await groupManagerFacet.getGroup("group1");

    //         expect(await groupManagerFacet.connect(contractOwner).removeGroup("group1")) //GroupRemovedFromIngester
    //         .to.emit(groupManagerFacet, "GroupRemovedFromIngester").withArgs(ingesters[0].address, "group1")
    //         .and.to.emit(groupManagerFacet, "GroupRemoved").withArgs("group1");
    //         const groupAfterRemoval = await groupManagerFacet.getGroup("group1");
    //         expect(groupAfterRemoval.isAdded).to.be.false;
    //         expect(groupAfterRemoval.ingesterAddresses.length == 0);

    //         for (let i = 0; i < groupAfterAddition.ingesterAddresses.length; i++) {
    //             let ingester = await groupManagerFacet.getIngesterWithGroups(groupAfterAddition.ingesterAddresses[i]);
    //             expect(ingester.assignedGroups).not.include("group1");
    //         }

    //     });

    //     it("should distribute to ingesters when groups are added", async () => {
    //         //each ingester should have at least 33 groups
    //         // check group assignement are within constraints
    //         for (let i = 0; i < numGroupsWithReplication; i++) {
    //             await groupManagerFacet.connect(contractOwner).addGroup(`group${i}`);
    //             const group = await groupManagerFacet.getGroup(`group${i}`);
    //             expect(group.isAdded).to.be.true;
    //             expect(group.ingesterAddresses.length <= newMaxIngestersPerGroup);
    //         }
            
    //         await checkClusterIsWithinConstraints(groupManagerFacet, registryFacet, maxClusterSize);
    //     });

    //     it("should revert when attempting to distribute more groups than the maxCapacity constraints", async () => {
    //         let clusterIds = await groupManagerFacet.getClusters();
    //         let getMaxGroupsPerIngester = BigNumber.from(await groupManagerFacet.getMaxGroupsPerIngester()).toNumber();
    //         let maxClusterSize = BigNumber.from(await groupManagerFacet.getMaxClusterSize()).toNumber();
    //         let getMaxIngestersPerGroup = BigNumber.from(await groupManagerFacet.getMaxIngestersPerGroup()).toNumber();
    
    //         let totalGroupsConstraint = (clusterIds.length * maxClusterSize * getMaxGroupsPerIngester) / getMaxIngestersPerGroup;
            
    //         for (let i = 0; i < totalGroupsConstraint; i++) {
    //             if(totalGroupsConstraint-1 == i) {
    //                 expect(await groupManagerFacet.connect(contractOwner).addGroup(`group${i}`)).to.revertedWith("No more ingesters available to add groups to");
    //             } else {
    //                 await groupManagerFacet.connect(contractOwner).addGroup(`group${i}`);
    //                 const group = await groupManagerFacet.getGroup(`group${i}`);
    //                 expect(group.isAdded).to.be.true;
    //                 expect(group.ingesterAddresses.length <= getMaxIngestersPerGroup)
    //             }
    //         }
    //     });

    //     it("should not add groups to unAllocated storage if ingester is removed while there is replication", async () => {
    //         // check group assignement are within constraints
    //         let totalAssignedGroups: string[] = [];
    //         for (let i = 0; i < numGroupsWithReplication; i++) {
    //             await groupManagerFacet.connect(contractOwner).addGroup(`group${i}`);
    //             const group = await groupManagerFacet.getGroup(`group${i}`);
    //             totalAssignedGroups.push(`group${i}`);
    //             expect(group.isAdded).to.be.true;
    //             expect(group.ingesterAddresses.length <= newMaxIngestersPerGroup)
    //         }
    
    //         let ingesterToRemove = await groupManagerFacet.getIngesterWithGroups(ingesters[0].address);
    //         let ingestersAllocatedCluster = BigNumber.from(ingesterToRemove.clusterId).toNumber();
    //         let maxGroupsPerIngesterBeforeUnregistering = await getClusterMaxGroupsPerIngester(groupManagerFacet, ingestersAllocatedCluster);
    
    //         let ingesterRemovedAssignedGroups: string[] = ingesterToRemove.assignedGroups;
    
    //         await registryFacet.connect(ingesterToController[ingesters[0].address]).unRegisterIngester(ingesters[0].address);
    //         await groupManagerFacet.distributeUnallocatedGroups();

    //         let clusterId = BigNumber.from(ingesterToRemove.clusterId).toNumber();
    //         let maxGroupsPerIngesterAfterUnregistering = await getClusterMaxGroupsPerIngester(groupManagerFacet, clusterId);
            
    //         expect(maxGroupsPerIngesterAfterUnregistering > maxGroupsPerIngesterBeforeUnregistering);
    
    //         //Get the new assigned groups after unregistration
    //         let totalAssignedGroupsAfterUnregistration: string[] = []
    //         let remainingIngesters: SignerWithAddress[] = ingesters.slice(1);
    //         for (let j = 0; j < remainingIngesters.length; j++) {
    //             let ingester = await groupManagerFacet.getIngesterWithGroups(remainingIngesters[j].address);
    //             totalAssignedGroupsAfterUnregistration = totalAssignedGroupsAfterUnregistration.concat(ingester.assignedGroups);
    //             expect(ingester.assignedGroups.length > maxGroupsPerIngesterBeforeUnregistering);
    //             expect(ingester.assignedGroups.length < maxGroupsPerIngesterAfterUnregistering);
    //         }
    
    //         //Grab unallocated groups and check if they are correctly unallocated and don't overlap with allocated groups
    //         let unAllocatedGroups = await groupManagerFacet.getUnallocatedGroups();
    //         expect(unAllocatedGroups.length == 0);
    
    //         //check if ingester was also removed from the cluster
    //         let cluster = await groupManagerFacet.getCluster(ingestersAllocatedCluster);
    //         expect(cluster.ingesterAddresses).not.include(ingesterToRemove.ingesterAddress);
    //     });

    //     it("should add to unassigned groups when entire cluster is removed", async () => {
    //         // check group assignement are within constraints
    //         for (let i = 0; i < numGroupsWithReplication; i++) {
    //             await groupManagerFacet.connect(contractOwner).addGroup(`group${i}`);
    //             const group = await groupManagerFacet.getGroup(`group${i}`);
    //             expect(group.isAdded).to.be.true;
    //             expect(group.ingesterAddresses.length <= maxIngestersPerGroup)
    //         }
    
    //         let ingestersRemaining = ingesters;
    //         let clusterId = 0;
    //         let ingesterRemovedAssignedGroups: string[];
    //         for (let i = 0; i < maxClusterSize; i++) {
    //             let ingesterToRemove = await groupManagerFacet.getIngesterWithGroups(ingesters[i].address);
                
    //             // _maxGroupsPerIngester = (numClusterGroups + numIngesters - 1) / numIngesters;
    //             clusterId = BigNumber.from(ingesterToRemove.clusterId).toNumber();
    //             let maxGroupsPerIngesterBeforeUnregistering = await getClusterMaxGroupsPerIngester(groupManagerFacet, clusterId);
    
    //             ingesterRemovedAssignedGroups = ingesterToRemove.assignedGroups;
                
    //             await registryFacet.connect(ingesterToController[ingesters[i].address]).unRegisterIngester(ingesters[i].address);
    //             await groupManagerFacet.connect(ingesterToController[ingesters[i].address]).getUnallocatedGroups();
    
    //             let maxGroupsPerIngesterAfterUnregistering = await getClusterMaxGroupsPerIngester(groupManagerFacet, clusterId);
    
    //             expect(maxGroupsPerIngesterAfterUnregistering > maxGroupsPerIngesterBeforeUnregistering);
    
    //             // Remove the ingester from structure
    //             let slicerIndex = i == 0 ? 1 : i;
    //             ingestersRemaining = ingestersRemaining.slice(slicerIndex);
    
    //             // check i remaining ingesters contain all the groups that were removed 
    //             let totalAssignedGroupsAfterUnregistration: string[] = []
    //             for (let j = 0; j < ingestersRemaining.length; j++) {
    //                 let ingester = await groupManagerFacet.getIngesterWithGroups(ingestersRemaining[j].address);
    //                 totalAssignedGroupsAfterUnregistration = totalAssignedGroupsAfterUnregistration.concat(ingester.assignedGroups);
    //                 expect(ingester.assignedGroups.length > maxGroupsPerIngesterBeforeUnregistering);
    //                 expect(ingester.assignedGroups.length < maxGroupsPerIngesterAfterUnregistering);
    //             }
    
    //             //Grab unallocated groups and check if they are correctly unallocated and don't overlap with allocated groups
    //             let unAllocatedGroups = await groupManagerFacet.getUnallocatedGroups();
    //             if (unAllocatedGroups.length > 0) {
    //                 const allocatedGroups = totalAssignedGroupsAfterUnregistration.filter(group => !unAllocatedGroups.includes(group));
                    
    //                 expect(allocatedGroups.length == totalAssignedGroupsAfterUnregistration.length);
    //                 const allGroupsAreReallocated = allocatedGroups.every(allocatedGroup => {
    //                     return totalAssignedGroupsAfterUnregistration.includes(allocatedGroup)
    //                 });
    //                 const allUnallocatedGroupsAreUnassigned = totalAssignedGroupsAfterUnregistration.every(allocatedGroup => {
    //                     return !unAllocatedGroups.includes(allocatedGroup)
    //                 })
    //                 expect(allGroupsAreReallocated).to.be.true;
    //                 expect(allUnallocatedGroupsAreUnassigned).to.be.true;
    
    //             } else {
    //                 //if no unallocated groups present, make sure that the all removed assigned groups have been re-allocated to the existing ingesters
    //                 const allGroupsAreReallocated = ingesterRemovedAssignedGroups.every(removedGroup => {
    //                     return totalAssignedGroupsAfterUnregistration.includes(removedGroup)
    //                 })
    //                 expect(allGroupsAreReallocated).to.be.true;
    //             }

    //             let cluster = await groupManagerFacet.getCluster(clusterId);
    //             if(i == maxClusterSize - 1) {
    //                 assert.strictEqual(cluster.ingesterAddresses.length, 0);
    //                 assert.sameMembers(unAllocatedGroups, ingesterRemovedAssignedGroups);
    //             }
    //         }
    //     });

    //     it("should allocate new groups when available to newly registered ingester", async () => {
    //         // check group assignement are within constraints
    //         let clusterIds = await groupManagerFacet.getClusters();
    //         let totalGroupsConstraint = (clusterIds.length * maxClusterSize * maxGroupsPerIngester) / newMaxIngestersPerGroup;

    //         for (let i = 0; i < totalGroupsConstraint; i++) {
    //             await groupManagerFacet.connect(contractOwner).addGroup(`group${i}`);
    //             const group = await groupManagerFacet.getGroup(`group${i}`);
    //             expect(group.isAdded).to.be.true;
    //             expect(group.ingesterAddresses.length <= newMaxIngestersPerGroup)
    //         }
    
    //         // use last available account as new test ingester to be registered
    //         let hash2 = await registryFacet.hash(accounts[accounts.length -1].address, message, nonce);
    //         const sig2 = await accounts[accounts.length - 2].signMessage(ethers.utils.arrayify(hash2));
    //         await registryFacet.connect(accounts[accounts.length - 2]).registerIngester(accounts[accounts.length - 1].address, message, nonce, sig2);
            
    //         // check all new incoming groups get allocated to the new ingester
    //         for (let i = totalGroupsConstraint; i < numGroupsWithReplication + 10; i++) {
    //             await groupManagerFacet.connect(contractOwner).addGroup(`group${i}`);
    //             const group = await groupManagerFacet.getGroup(`group${i}`);
    //             expect(group.isAdded).to.be.true;
    //             expect(group.ingesterAddresses).to.include(accounts[accounts.length -1].address);
    //             expect(group.ingesterAddresses.length <= maxIngestersPerGroup)
    
    //             let newIngester = await groupManagerFacet.getIngesterWithGroups(accounts[accounts.length -1].address);
    //             expect(newIngester.assignedGroups).to.include(`group${i}`);
    //         }
    //     });

    //     it("should restrict one controller wallet owning more than one ingester per cluster", async () => {
    //         let numIngestersToAdd = 2;
    //         let controllerAccount = accounts[0];
    //         let newIngesters: SignerWithAddress[] = [];
    //         for (let i = accounts.length - 1; i >= accounts.length - numIngestersToAdd; i-- ) {
    //             let hash = await registryFacet.hash(accounts[i].address, message, nonce);
    //             const sig = await controllerAccount.signMessage(ethers.utils.arrayify(hash));
    //             await registryFacet.connect(controllerAccount).registerIngester(accounts[i].address, message, nonce, sig);
    //             await groupManagerFacet.connect(controllerAccount).distributeGroupsToIngester(accounts[i].address);
    //             newIngesters.push(accounts[i]);

    //         }

    //         let controllerIngesters = await groupManagerFacet.getControllerIngesters(controllerAccount.address);
    //         let clusterIds: number[] = [];
    //         for (const ingesterAccount of controllerIngesters) {
    //             let ingester = await groupManagerFacet.getIngesterWithGroups(ingesterAccount.ingesterAddress);
    //             clusterIds.push(BigNumber.from(ingester.clusterId).toNumber());
    //         }
    //         expect(allUnique(clusterIds)).to.be.true;
    //     });

    //     it("should add groups to newly registered ingester if capacity allows", async () => {
    //         // let maxGroupsPerCluster = numIngesters * maxGroupsPerIngester;
    //         let clusterIds = await groupManagerFacet.getClusters();
    //         let totalGroupsConstraint = (clusterIds.length * maxClusterSize * maxGroupsPerIngester) / newMaxIngestersPerGroup;
    
    //         // Add maximum groups possible
    //         let totalAssignedGroups: string[] = [];
    //         for (let i = 0; i < totalGroupsConstraint; i++) {
    //             await groupManagerFacet.connect(contractOwner).addGroup(`group${i}`);
    //             const group = await groupManagerFacet.getGroup(`group${i}`);
    //             totalAssignedGroups.push(`group${i}`);
    //             expect(group.isAdded).to.be.true;
    //             expect(group.ingesterAddresses.length <= newMaxIngestersPerGroup)
    //         }
    
    //         await registryFacet.connect(ingesterToController[ingesters[0].address]).unRegisterIngester(ingesters[0].address);
    //         await groupManagerFacet.distributeUnallocatedGroups();

    //         expect(groupManagerFacet.getIngesterWithGroups(ingesters[0].address)).to.be.revertedWith("Ingester does not exist.");
    
    //         //register Ingester again and check if the unallocated groups get allocated again
    //         let hash = await registryFacet.hash(ingesters[0].address, message, nonce);
    //         const sig = await ingesterToController[ingesters[0].address].signMessage(ethers.utils.arrayify(hash));
    //         await registryFacet.connect(ingesterToController[ingesters[0].address]).registerIngester(ingesters[0].address, message, nonce, sig);
            
    //         //Distribute groups after registration
    //         let ingesterBeforeDistribution = await groupManagerFacet.getIngesterWithGroups(ingesters[0].address);
    //         let distributeTx = await groupManagerFacet.connect(ingesterToController[ingesters[0].address]).distributeGroupsToIngester(ingesters[0].address);
    //         let ingesterAfterDistribution = await groupManagerFacet.getIngesterWithGroups(ingesters[0].address);
    
    //         //check that the assigned groups to ingester with replication is the same as the other ingesters within cluster
    //         let cluster = await groupManagerFacet.getCluster(ingesterBeforeDistribution.clusterId);
    //         let ingesterWithinCluster = await groupManagerFacet.getIngesterWithGroups(cluster.ingesterAddresses[0]);
    //         expect(ingesterWithinCluster.assignedGroups == ingesterAfterDistribution.assignedGroups);
    //     });
    // });
    
});

