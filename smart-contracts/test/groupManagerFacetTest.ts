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
import cluster from "cluster";

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

    describe("Manage Groups With Replication", function () {
        const newMaxIngestersPerGroup = 3;
        let groupsAdded = []

        let numGroupsWithReplication: number;
        beforeEach(async function () {
            numGroupsWithReplication = maxAllocatableGroups; 
            console.log("🚀 ~ file: groupManagerFacetTest.ts:351 ~ numGroupsWithReplication:", numGroupsWithReplication)
            // add replication of 3
            await groupManagerFacet.setMaxIngestersPerGroup(newMaxIngestersPerGroup);

            for (let i = 0; i < numGroupsWithReplication; i++) {
                await groupManagerFacet.connect(contractOwner).addGroup(`group${i}`);
                const group = await groupManagerFacet.getGroup(`group${i}`);
                groupsAdded.push(`group${i}`);
            }
        });

        it("should have set maxNumberIngesterPerGroup correctly", async () => {
            let newMaxNumberIngesterPerGroup = BigNumber.from(await groupManagerFacet.getMaxIngestersPerGroup()).toNumber();
            expect(newMaxNumberIngesterPerGroup).to.equal(newMaxIngestersPerGroup);
        });
    
        it("should add ingesters to group cluster with replication", async () => {

            numIngesters = 6;
            ingesters = []
            ingesterToController = {}
            for (let i = 1; i <= numIngesters; i++ ) {
                let hash = await registryFacet.hash(accounts[i].address, message, nonce);
                const sig = await accounts[i-1].signMessage(ethers.utils.arrayify(hash));
                await registryFacet.connect(accounts[i-1]).registerIngester(accounts[i].address, message, nonce, sig);
                ingesterToController[accounts[i].address] = accounts[i-1];
                ingesters.push(accounts[i]);
            }

            let clusters = await groupManagerFacet.getClusters();
            let cluster1 = await groupManagerFacet.getCluster(BigNumber.from(clusters[0]).toNumber());
            let cluster2 = await groupManagerFacet.getCluster(BigNumber.from(clusters[1]).toNumber());
            
            //check that there is only one cluster and it contains all three ingesters
            expect(clusters.length == 2);
            expect(cluster1.ingesterAddresses.length == numGroupsWithReplication);
            expect(cluster2.ingesterAddresses.length == numGroupsWithReplication);

            for (let i = 0; i < ingesters.length / 2; i++) {
                let ingester = await registryFacet.getIngesterWithGroups(ingesters[i].address);
                assert.sameMembers(ingester.assignedGroups, cluster1.groupUsernames);
            }

            for (let i = ingesters.length / 2; i < ingesters.length; i++) {
                let ingester = await registryFacet.getIngesterWithGroups(ingesters[i].address);
                assert.sameMembers(ingester.assignedGroups, cluster2.groupUsernames);
            }
        });

        it("should remove an existing group should remove it from cluster and all associated ingesters", async () => {
            const groupName = "group1";
            const group = await groupManagerFacet.getGroup("group1");
            const ingestersToCheck = group.ingesterAddresses;

            await expect(groupManagerFacet.connect(contractOwner).removeGroup(groupName)) //GroupRemovedFromIngester
            .to.emit(groupManagerFacet, "GroupRemovedFromCluster").withArgs(0, groupName)
            .and.to.emit(groupManagerFacet, "GroupRemoved").withArgs(groupName);
            const groupAfterRemoval = await groupManagerFacet.getGroup(groupName);

            expect(groupAfterRemoval.isAdded).to.be.false;
            expect(groupAfterRemoval.ingesterAddresses.length == 0);

            for (let i = 0; i < ingestersToCheck.length; i++) {
                let ingester = await groupManagerFacet.getIngesterWithGroups(ingestersToCheck[i]);
                expect(ingester.assignedGroups).not.include(groupName);
            }
        });

        it("should move all ingesters to other available clusters when all cluster groups within cluster are removed and make cluster inactive", async () => {
            let numClusters = BigNumber.from(await groupManagerFacet.getClusterCount()).toNumber();
            let numIngesters = (numClusters - 1) * 3; // want to have an empty cluster for this test
         
            ingesters = []
            ingesterToController = {}
            for (let i = 1; i <= numIngesters; i++ ) {
                let hash = await registryFacet.hash(accounts[i].address, message, nonce);
                const sig = await accounts[i-1].signMessage(ethers.utils.arrayify(hash));
                await registryFacet.connect(accounts[i-1]).registerIngester(accounts[i].address, message, nonce, sig);
                ingesterToController[accounts[i].address] = accounts[i-1];
                ingesters.push(accounts[i]);
            }

            let emptyCluster = await groupManagerFacet.getCluster(numClusters - 1);
            expect(emptyCluster.ingesterAddresses.length == 0);

            let clusterToEmpty = await groupManagerFacet.getCluster(numClusters - 2);
            let groupsToRemove = clusterToEmpty.groupUsernames;
            let ingestersToMove = clusterToEmpty.ingesterAddresses;

            for (let i = 0; i < groupsToRemove.length; i++ ) {
                let groupRemovalTx = await groupManagerFacet.removeGroup(groupsToRemove[i]);
                if ( i == groupsToRemove.length - 1) {
                    await expect(groupRemovalTx).to.emit(groupManagerFacet, "GroupRemovedFromCluster")
                    .and.to.emit(groupManagerFacet, "InactivateCluster").withArgs(numClusters - 2)
                    .and.to.emit(groupManagerFacet, "IngesterAddedToCluster");
                }
            }

            let emptyClusterFilled = await groupManagerFacet.getCluster(numClusters - 1);

            assert.sameMembers(emptyClusterFilled.ingesterAddresses, ingestersToMove);

            for (let i = 0; i < ingestersToMove.length; i++) {
                let ingester = await registryFacet.getIngesterWithGroups(ingestersToMove[i]);
                assert.sameMembers(ingester.assignedGroups, emptyClusterFilled.groupUsernames);
            }

            clusterToEmpty = await groupManagerFacet.getCluster(numClusters - 2);

            expect(clusterToEmpty.isActive).to.be.false;
        });

        it("should move possible ingesters to other available clusters when all cluster groups within cluster are removed and make cluster inactive", async () => {
            let numClusters = BigNumber.from(await groupManagerFacet.getClusterCount()).toNumber();
            let numIngesters = ((numClusters - 1) * 3) + 1; // want to have an empty cluster for this test
         
            ingesters = []
            ingesterToController = {}
            for (let i = 1; i <= numIngesters; i++ ) {
                let hash = await registryFacet.hash(accounts[i].address, message, nonce);
                const sig = await accounts[i-1].signMessage(ethers.utils.arrayify(hash));
                await registryFacet.connect(accounts[i-1]).registerIngester(accounts[i].address, message, nonce, sig);
                ingesterToController[accounts[i].address] = accounts[i-1];
                ingesters.push(accounts[i]);
            }

            let emptyCluster = await groupManagerFacet.getCluster(numClusters - 1);
            expect(emptyCluster.ingesterAddresses.length == 0);

            let clusterToEmpty = await groupManagerFacet.getCluster(numClusters - 2);
            let groupsToRemove = clusterToEmpty.groupUsernames;
            let ingestersToMove = clusterToEmpty.ingesterAddresses;

            for (let i = 0; i < groupsToRemove.length; i++ ) {
                let groupRemovalTx = await groupManagerFacet.removeGroup(groupsToRemove[i]);
                if ( i == groupsToRemove.length - 1) {
                    await expect(groupRemovalTx).to.emit(groupManagerFacet, "GroupRemovedFromCluster")
                    .and.to.emit(groupManagerFacet, "InactivateCluster").withArgs(numClusters - 2)
                    .and.to.emit(groupManagerFacet, "IngesterAddedToCluster")
                    .and.to.emit(groupManagerFacet, "UnAllocatedIngesterAdded");
                }
            }

            clusterToEmpty = await groupManagerFacet.getCluster(numClusters - 2);
            expect(clusterToEmpty.isActive).to.be.false;

            //third cluster should now be filled with ingesters
            let emptyClusterFilled = await groupManagerFacet.getCluster(numClusters - 1);
            expect(emptyClusterFilled.ingesterAddresses.length == newMaxIngestersPerGroup);

            //one ingester should be unallocated
            let unallocatedIngester = await registryFacet.getUnAllocatedIngesters();
            expect(unallocatedIngester.length == 1);
            expect(ingestersToMove).to.include(unallocatedIngester[0]);
        });

        it("should re-active an inactive cluster when new groups are added", async () => {
            let numClusters = BigNumber.from(await groupManagerFacet.getClusterCount()).toNumber();
            let numIngesters = (numClusters - 1) * 3; // want to have an empty cluster for this test
            
            // add the ingesters
            ingesters = []
            ingesterToController = {}
            for (let i = 1; i <= numIngesters; i++ ) {
                let hash = await registryFacet.hash(accounts[i].address, message, nonce);
                const sig = await accounts[i-1].signMessage(ethers.utils.arrayify(hash));
                await registryFacet.connect(accounts[i-1]).registerIngester(accounts[i].address, message, nonce, sig);
                ingesterToController[accounts[i].address] = accounts[i-1];
                ingesters.push(accounts[i]);
            }

            let emptyCluster = await groupManagerFacet.getCluster(numClusters - 1);
            expect(emptyCluster.ingesterAddresses.length == 0);

            let clusterToEmpty = await groupManagerFacet.getCluster(numClusters - 2);
            let groupsToRemove = clusterToEmpty.groupUsernames;
            let ingestersToMove = clusterToEmpty.ingesterAddresses;

            //remove all the groups from the cluster
            for (let i = 0; i < groupsToRemove.length; i++ ) {
                let groupRemovalTx = await groupManagerFacet.removeGroup(groupsToRemove[i]);
            }
            clusterToEmpty = await groupManagerFacet.getCluster(numClusters - 2);
            expect(clusterToEmpty.isActive).to.be.false;

            let inactiveClusterId = await groupManagerFacet.getInActiveClusters();
            let inactiveCluster = await groupManagerFacet.getCluster(inactiveClusterId[0]);

            //add new groups that haven't previously been added
            let groupsAdded = []
            let upperBound = numGroupsWithReplication + maxGroupsPerIngester;
            for (let i = numGroupsWithReplication; i < upperBound; i++ ) {
                let groupAddTx = await groupManagerFacet.addGroup(`group${i}`);
                groupsAdded.push(`group${i}`);
                if (i == numGroupsWithReplication) {
                    await expect(groupAddTx).to.emit(groupManagerFacet, "ActivateInactiveCluster").withArgs(BigNumber.from(inactiveClusterId[0]).toNumber());
                }
            }

            inactiveCluster = await groupManagerFacet.getCluster(BigNumber.from(inactiveClusterId[0]).toNumber());
            expect(inactiveCluster.isActive).to.be.true;
            assert.sameMembers(inactiveCluster.groupUsernames, groupsAdded);
        });

        it("should restrict one controller wallet owning more than one ingester per cluster", async () => {
            let numIngestersToAdd = 3;
            let controllerAccount = accounts[0];
            let newIngesters: SignerWithAddress[] = [];
            for (let i = accounts.length - 1; i >= accounts.length - numIngestersToAdd; i-- ) {
                let hash = await registryFacet.hash(accounts[i].address, message, nonce);
                const sig = await controllerAccount.signMessage(ethers.utils.arrayify(hash));
                await registryFacet.connect(controllerAccount).registerIngester(accounts[i].address, message, nonce, sig);
                newIngesters.push(accounts[i]);

            }

            let controllerIngesters = await groupManagerFacet.getControllerIngesters(controllerAccount.address);
            let clusterIds: number[] = [];
            for (const ingesterAccount of controllerIngesters) {
                let ingester = await groupManagerFacet.getIngesterWithGroups(ingesterAccount.ingesterAddress);
                clusterIds.push(BigNumber.from(ingester.clusterId).toNumber());
            }
            expect(allUnique(clusterIds)).to.be.true;
        });
    });
});

