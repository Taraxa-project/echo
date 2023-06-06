import {
    DiamondCutFacet,
    DiamondLoupeFacet,
    GroupManagerFacet,
    OwnershipFacet,
    RegistryFacet,
    } from "../typechain-types";
import { deployDiamondTest } from "../scripts/deployDiamondTest";

import { ethers } from "hardhat";
import { BigNumber } from "ethers";
import { assert, expect } from "chai";
import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";

import {IngesterControllerMapping,
    allUnique,
    addFacetsToDiamond,
 } from "./testUtils/testUtils";
import { group } from "console";

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

const maxClusterSize = 10;
const maxIngestersPerGroup = 1;

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
    const maxAllocatableGroups: number = numIngesters * maxClusterSize;
    console.log("🚀 ~ file: groupManagerFacetTest.ts:59 ~ maxAllocatableGroups:", maxAllocatableGroups)
    const numIngestersToRemove = 2;
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
    });
        
    it("should set maxNumberIngesterPerGroup correctly with deployment", async () => {
        const maxIngesterPerGroupRes = BigNumber.from(await groupManagerFacet.getMaxIngestersPerGroup()).toNumber();
        expect(maxIngesterPerGroupRes).to.equal(maxIngestersPerGroup);
    });
    
    it("should be able to set a new maxNumberIngesterPerGroup", async () => {
        await expect( groupManagerFacet.connect(contractOwner).setMaxIngestersPerGroup(10)).to.emit(groupManagerFacet, "MaxIngesterPerGroupUpdated");
        let newMaxNumberIngesterPerGroup = BigNumber.from(await groupManagerFacet.getMaxIngestersPerGroup()).toNumber();
        expect(newMaxNumberIngesterPerGroup).to.equal(10);
    });

    it("should be able to set a new setMaxClusterSize", async () => {
        let newMaxClusterSize = 5;
        await expect( groupManagerFacet.connect(contractOwner).setMaxClusterSize(newMaxClusterSize)).to.emit(groupManagerFacet, "MaxClusterSizeUpdated");
        let maxClusterSize = BigNumber.from(await groupManagerFacet.getMaxClusterSize()).toNumber();
        expect(maxClusterSize).to.equal(newMaxClusterSize);
    });

    it("should add a new group", async () => {
        await expect(groupManagerFacet.connect(contractOwner).addGroup("group1")).to.emit(groupManagerFacet, "GroupAdded").withArgs("group1");
        const group = await groupManagerFacet.getGroup("group1");
        let groupUserNameIndex = BigNumber.from(group.groupUsernameIndex).toNumber();
        let groupUsernames = await groupManagerFacet.getGroupUsernameByIndex(groupUserNameIndex);
        expect(group.isAdded).to.be.true;
        expect(groupUsernames == "group1");
    });

    it("should not be able to add a group with an empty string", async () => {
        await expect(groupManagerFacet.connect(contractOwner).addGroup("")).to.be.revertedWith("GroupUsername is empty");
    });

    it("should not be able to add repeated groups", async () => {
        await expect( groupManagerFacet.connect(contractOwner).addGroup("group1")).to.emit(groupManagerFacet, "GroupAdded").withArgs("group1");
        await expect( groupManagerFacet.connect(contractOwner).addGroup("group1")).to.be.revertedWith("Group already exists.");
    });

    it("should remove an existing group", async () => {
        await groupManagerFacet.connect(contractOwner).addGroup("group1");

        await expect(groupManagerFacet.connect(contractOwner).removeGroup("group1"))
        .and.to.emit(groupManagerFacet, "GroupRemoved").withArgs("group1")
        .and.to.emit(groupManagerFacet, "GroupRemovedFromCluster").withArgs(0, "group1");
        await expect(groupManagerFacet.getGroup("group1")).to.be.reverted;
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
            await expect(groupManagerFacet.getGroup(`group${i}`)).to.be.reverted;
        }

        let inactiveClusters = await groupManagerFacet.getinactiveClusters();
        expect(inactiveClusters.length == clusters.length);
    });

    it("should create new group clusters when maxClusterSize is exceeded" , async () => {
        let numClusters = Math.round(maxAllocatableGroups / maxClusterSize);
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
            groupCounts.push(BigNumber.from(clusterDetails.groupUsernames.length).toNumber());
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
        expect(cluster.ingesterAddresses.length == 0);
    });

    it("should allocate unAllocated ingester when available to newly added Groups", async () => {

        // use last available account as new test ingester to be registered
        let hash = await registryFacet.hash(accounts[1].address, message, nonce);
        const sig = await accounts[0].signMessage(ethers.utils.arrayify(hash));
        let registrationTx = await registryFacet.connect(accounts[0]).registerIngester(accounts[1].address, message, nonce, sig);

        await expect(registrationTx).to.emit(registryFacet, "UnAllocatedIngesterAdded").withArgs(accounts[1].address);
        
        let groupsAdded = [];
        for (let i = 0; i < maxClusterSize; i++) {
            let groupTx = await groupManagerFacet.connect(contractOwner).addGroup(`group${i}`);
            if ( i == 0){
                await expect(groupTx).to.emit(groupManagerFacet, "IngesterAddedToCluster").withArgs(0, accounts[1].address);
                let cluster = await registryFacet.getCluster(0);
                expect(cluster.ingesterAddresses).to.include(accounts[1].address);
            }
            const group = await groupManagerFacet.getGroup(`group${i}`);
            expect(group.isAdded).to.be.true;
            expect(group.ingesterAddresses.length <= maxIngestersPerGroup);
            groupsAdded.push(`group${i}`);

        }

        let ingester = await registryFacet.getIngesterWithGroups(accounts[1].address);
        assert.sameMembers(groupsAdded, ingester.assignedGroups);
    });

    it("should add unaloccated groups to newly registered ingester if capacity allows", async () => {
        let ingesterCount = 2;
        let maxTwoGroupsGroups = ingesterCount * maxClusterSize;

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

    it("should return the unallocated groups correctly when a cluster is not monitored", async () => {
        let ingesterCount = 2;
        let maxTwoGroupsGroups = ingesterCount * maxClusterSize;

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

        let unregistrationTx = await registryFacet.connect(ingesterToController[ingesters[1].address]).unRegisterIngester(ingesters[1].address);

        await expect(unregistrationTx).to.emit(registryFacet, "ClusterHasNoIngesters").withArgs(1);

        let cluster2AfterUnregistration = await registryFacet.getCluster(1);
        expect( cluster2AfterUnregistration.ingesterAddresses.length == 0);

        let unallocatedGroups = await groupManagerFacet.getunallocatedGroups();
        assert.sameMembers(unallocatedGroups, cluster2AfterUnregistration.groupUsernames);
    });


    describe("Manage Groups With Replication", function () {
        const newMaxIngestersPerGroup = 3;
        let groupsAdded = []

        let numGroupsWithReplication: number;
        beforeEach(async function () {
            numGroupsWithReplication = maxAllocatableGroups; 
            await groupManagerFacet.setMaxIngestersPerGroup(newMaxIngestersPerGroup);

            console.log("🚀 ~ file: groupManagerFacetTest.ts:352 ~ numGroupsWithReplication:", numGroupsWithReplication)
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
            let numClusters = BigNumber.from(await registryFacet.getClusterCount()).toNumber();
            numIngesters = numClusters * newMaxIngestersPerGroup;
            ingesters = []
            ingesterToController = {}
            let ingestersAddresses: string[] = []
            for (let i = 1; i <= numIngesters; i++ ) {
                let hash = await registryFacet.hash(accounts[i].address, message, nonce);
                const sig = await accounts[i-1].signMessage(ethers.utils.arrayify(hash));
                await registryFacet.connect(accounts[i-1]).registerIngester(accounts[i].address, message, nonce, sig);
                ingesterToController[accounts[i].address] = accounts[i-1];
                ingestersAddresses.push(accounts[i].address);
            }

            let clusters = await groupManagerFacet.getClusters();
            expect(clusters.length == numClusters);
            clusters.map(async (cluster) => {
                let clusterDetails = await groupManagerFacet.getCluster(BigNumber.from(cluster).toNumber());
                expect(clusterDetails.ingesterAddresses.length == numGroupsWithReplication);
                expect(clusterDetails.ingesterAddresses).to.include(ingestersAddresses);
            });
        });

        it("should remove an existing group should remove it from cluster and all associated ingesters", async () => {
            const groupName = "group1";
            const group = await groupManagerFacet.getGroup("group1");
            const ingestersToCheck = group.ingesterAddresses;

            await expect(groupManagerFacet.connect(contractOwner).removeGroup(groupName)) 
            .to.emit(groupManagerFacet, "GroupRemovedFromCluster").withArgs(0, groupName)
            .and.to.emit(groupManagerFacet, "GroupRemoved").withArgs(groupName);
            await expect(groupManagerFacet.getGroup(groupName)).to.be.reverted;

            for (let i = 0; i < ingestersToCheck.length; i++) {
                let ingester = await groupManagerFacet.getIngesterWithGroups(ingestersToCheck[i]);
                expect(ingester.assignedGroups).not.include(groupName);
            }
        });

        it("should move all ingesters to other available clusters when all cluster groups within cluster are removed and make cluster inactive", async () => {
            let numClusters = BigNumber.from(await groupManagerFacet.getClusterCount()).toNumber();
            let numIngesters = (numClusters - 1) * 3; // want to have an empty cluster for this test
            let clusterIdRemove = 0;
         
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

            let clusters = await groupManagerFacet.getClusters();
            let clusterToEmpty = await groupManagerFacet.getCluster(clusterIdRemove);
            let groupsToRemove = clusterToEmpty.groupUsernames;
            let ingestersToMove = clusterToEmpty.ingesterAddresses;

            for (let i = 0; i < groupsToRemove.length; i++ ) {
                let groupRemovalTx = await groupManagerFacet.removeGroup(groupsToRemove[i]);
                if ( i == groupsToRemove.length - 1) {
                    await expect(groupRemovalTx).to.emit(groupManagerFacet, "GroupRemovedFromCluster")
                    .and.to.emit(groupManagerFacet, "InactivateCluster").withArgs(clusterIdRemove)
                    .and.to.emit(groupManagerFacet, "IngesterAddedToCluster");
                }
            }

            clusters = await groupManagerFacet.getClusters();
            let remainingClusters = clusters.filter(cluster => BigNumber.from(cluster).toNumber() != clusterIdRemove);

            remainingClusters.map( async cluster => {
                let clusterId = BigNumber.from(cluster).toNumber();
                let clusterDetails = await groupManagerFacet.getCluster(clusterId)
                expect(clusterDetails.ingesterAddresses).to.include(ingestersToMove);
            })

            clusterToEmpty = await groupManagerFacet.getCluster(clusterIdRemove);
            expect(clusterToEmpty.isActive).to.be.false;
            expect(clusterToEmpty.ingesterAddresses.length == 0);
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
            let unallocatedIngester = await registryFacet.getunallocatedIngesters();
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

            let inactiveClusterId = await groupManagerFacet.getinactiveClusters();
            let inactiveCluster = await groupManagerFacet.getCluster(inactiveClusterId[0]);

            //add new groups that haven't previously been added
            let groupsAdded = []
            let upperBound = numGroupsWithReplication + maxClusterSize;
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

        it("should fetch available ingesters when group cluster is re-activated", async () => {

            let numIngesters = newMaxIngestersPerGroup + 1; // want to have an empty cluster for this test
            let clusterIdToEmpty = 0;
            let clusterIdEmpty = 1;
            
            // add the ingesters
            ingesters = []
            ingesterToController = {}
            for (let i = 1; i <= numIngesters; i++ ) {
                let hash = await registryFacet.hash(accounts[i].address, message, nonce);
                const sig = await accounts[i-1].signMessage(ethers.utils.arrayify(hash));
                await registryFacet.connect(accounts[i-1]).registerIngester(accounts[i].address, message, nonce, sig);
                ingesterToController[accounts[i].address] = accounts[i-1];
                ingesters.push(accounts[i]);
                let ingester = await registryFacet.getIngesterWithGroups(accounts[i].address);
            }

            let emptyCluster = await groupManagerFacet.getCluster(clusterIdEmpty);
            expect(emptyCluster.ingesterAddresses.length == 0);

            let clusterToEmpty = await groupManagerFacet.getCluster(clusterIdToEmpty);
            let groupsToRemove = clusterToEmpty.groupUsernames;
            let ingestersToMove = clusterToEmpty.ingesterAddresses;

            //remove all the groups from the cluster
            for (let i = 0; i < groupsToRemove.length; i++ ) {
                let groupRemovalTx = await groupManagerFacet.removeGroup(groupsToRemove[i]);
            }
            clusterToEmpty = await groupManagerFacet.getCluster(clusterIdToEmpty);
            expect(clusterToEmpty.isActive).to.be.false;

            let inactiveClusterId = await groupManagerFacet.getinactiveClusters();
            expect(inactiveClusterId.length == 1);
            //add all the groups from the emptied cluster back in
            for (let i = 0; i < groupsToRemove.length; i++ ) {
                let groupRemovalTx = await groupManagerFacet.addGroup(groupsToRemove[i]);
                if ( i == 0) {
                    await expect(groupRemovalTx).to.emit(groupManagerFacet, "GroupAdded").withArgs(groupsToRemove[i])
                    .and.to.emit(groupManagerFacet, "ActivateInactiveCluster")
                    .and.to.emit(groupManagerFacet, "IngesterRemovedFromCluster")
                    .and.to.emit(groupManagerFacet, "IngesterAddedToCluster")
                }
            }
            let cluster = await groupManagerFacet.getCluster(clusterIdToEmpty);
            expect(cluster.ingesterAddresses.length == 1);            
        });


        it("should fetch all possible unAllocated ingesters when group cluster is created and not allow duplicate controllers within cluster", async () => {
            let numIngesterUnallocated = 3;
            let numIngesters = newMaxIngestersPerGroup + numIngesterUnallocated; 
            
            // add the ingesters
            ingesters = []
            ingesterToController = {}
            let controller = accounts[accounts.length-1];
            let ingestersWithSameController: string[] = [];
            for (let i = 1; i <= numIngesters; i++ ) {
                let hash = await registryFacet.hash(accounts[i].address, message, nonce);
                if (i >= numIngesters - 1){
                    const sig = await controller.signMessage(ethers.utils.arrayify(hash));
                    await registryFacet.connect(controller).registerIngester(accounts[i].address, message, nonce, sig);
                    ingesterToController[accounts[i].address] = controller;
                    ingestersWithSameController.push(accounts[i].address);
                } else {
                    const sig = await accounts[i-1].signMessage(ethers.utils.arrayify(hash));
                    await registryFacet.connect(accounts[i-1]).registerIngester(accounts[i].address, message, nonce, sig);
                    ingesterToController[accounts[i].address] = accounts[i-1];
                    ingesters.push(accounts[i]);
                }
            }
            let clusters = await groupManagerFacet.getClusters();
           
            //remove last two clusters
            let groupsToRemove: string[] = []
            for (let i = clusters.length - 1; i > clusters.length - numIngesterUnallocated; i--) {
                groupsToRemove = [];
                let cluster = await groupManagerFacet.getCluster(clusters[i]);
                groupsToRemove = cluster.groupUsernames;
                for (let j = 0; j < groupsToRemove.length ; j++) {
                    await groupManagerFacet.removeGroup(groupsToRemove[j]);
                }
            }

            let unallocatedIngesters = await groupManagerFacet.getunallocatedIngesters();
            expect(unallocatedIngesters.length == numIngesterUnallocated);

            //add groups back in
            for (let i = 0; i < groupsToRemove.length; i++ ) {
                await groupManagerFacet.addGroup(groupsToRemove[i]);
            }

            clusters = await groupManagerFacet.getClusters();
            for (let i =0; i < clusters.length; i++) {
                let cluster = await groupManagerFacet.getCluster(clusters[i]);
                //last cluster should not have anything allocated, but the other two should have an ingester allocated to them
                if (i != cluster.length - 1) {
                    expect(cluster.ingesterAddresses.length == 3 );
                }
            }

            //1 ingester should remain as 2 ingesters have the same controller
            //check if the remaining ingester is within ingestersWithSameController array
            let unallocatedIngestersAfter = await groupManagerFacet.getunallocatedIngesters();
            expect(unallocatedIngestersAfter.length == 1);
            const isIncluded = unallocatedIngestersAfter.some(r=> ingestersWithSameController.includes(r));
            expect(isIncluded).to.be.true;
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

