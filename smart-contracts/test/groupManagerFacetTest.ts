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
    const numIngestersToRemove = 2;
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

        //take half of the total allocatable groups so there is space in the cluster to re-allocate for this test
        let numGroups = maxAllocatableGroups / 2;
        for (let i = 0; i < numGroups; i++) {
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

        //unregister and distribute unallocated groups
        await registryFacet.connect(ingesterToController[ingesters[0].address]).unRegisterIngester(ingesters[0].address);
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
        
        //Grab unallocated groups and check if they are correctly unallocated and don't overlap with allocated groups
        let unAllocatedGroups = await groupManagerFacet.getUnallocatedGroups();
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

    it("should re-adjust groups when multiple ingesters are removed", async () => {
        // check group assignement are within constraints
        //take half of the total allocatable groups so there is space in the cluster to re-allocate for this test
        let numGroups = maxAllocatableGroups / 2;
        for (let i = 0; i < numGroups; i++) {
            await groupManagerFacet.connect(contractOwner).addGroup(`group${i}`);
            const group = await groupManagerFacet.getGroup(`group${i}`);
            expect(group.isAdded).to.be.true;
            expect(group.ingesterAddresses.length <= maxIngestersPerGroup)
        }

        let ingestersRemaining = ingesters;
        for (let i = 0; i < numIngestersToRemove; i++) {
            let ingesterToRemove = await groupManagerFacet.getIngesterWithGroups(ingesters[i].address);
            
            // _maxGroupsPerIngester = (numClusterGroups + numIngesters - 1) / numIngesters;
            let clusterId = BigNumber.from(ingesterToRemove.clusterId).toNumber();
            let maxGroupsPerIngesterBeforeUnregistering = await getClusterMaxGroupsPerIngester(groupManagerFacet, clusterId);

            let ingesterRemovedAssignedGroups: string[] = ingesterToRemove.assignedGroups;
            
            await registryFacet.connect(ingesterToController[ingesters[i].address]).unRegisterIngester(ingesters[i].address);
            await groupManagerFacet.distributeUnallocatedGroups();
            
            let maxGroupsPerIngesterAfterUnregistering = await getClusterMaxGroupsPerIngester(groupManagerFacet, clusterId);

            expect(maxGroupsPerIngesterAfterUnregistering > maxGroupsPerIngesterBeforeUnregistering);

            // Remove the ingester from structure
            let slicerIndex = i == 0 ? 1 : i;
            ingestersRemaining = ingestersRemaining.slice(slicerIndex);

            // check i remaining ingesters contain all the groups that were removed 
            let totalAssignedGroupsAfterUnregistration: string[] = []
            for (let j = 0; j < ingestersRemaining.length; j++) {
                let ingester = await groupManagerFacet.getIngesterWithGroups(ingestersRemaining[j].address);
                totalAssignedGroupsAfterUnregistration = totalAssignedGroupsAfterUnregistration.concat(ingester.assignedGroups);
                expect(ingester.assignedGroups.length > maxGroupsPerIngesterBeforeUnregistering);
                expect(ingester.assignedGroups.length < maxGroupsPerIngesterAfterUnregistering);
            }

            //Grab unallocated groups and check if they are correctly unallocated and don't overlap with allocated groups
            let unAllocatedGroups = await groupManagerFacet.getUnallocatedGroups();

            if (unAllocatedGroups.length > 0) {
                const allocatedGroups = totalAssignedGroupsAfterUnregistration.filter(group => {
                    return !unAllocatedGroups.includes(group)
                })
                
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
                //if no unallocated groups present, make sure that the all removed assigned groups have been re-allocated to the existing ingesters
                const allGroupsAreReallocated = ingesterRemovedAssignedGroups.every(removedGroup => {
                    return totalAssignedGroupsAfterUnregistration.includes(removedGroup)
                })
                expect(allGroupsAreReallocated).to.be.true;
            }
        }
    });

    it("should allocate new groups when available to newly registered ingester", async () => {
        // check group assignement are within constraints
        let maxNumberOfGroups = maxGroupsPerIngester * numIngesters;
        for (let i = 0; i < maxNumberOfGroups; i++) {
            await groupManagerFacet.connect(contractOwner).addGroup(`group${i}`);
            const group = await groupManagerFacet.getGroup(`group${i}`);
            expect(group.isAdded).to.be.true;
            expect(group.ingesterAddresses.length <= maxIngestersPerGroup);
        }

        // use last available account as new test ingester to be registered
        let hash2 = await registryFacet.hash(accounts[accounts.length -1].address, message, nonce);
        const sig2 = await accounts[accounts.length - 2].signMessage(ethers.utils.arrayify(hash2));
        await registryFacet.connect(accounts[accounts.length - 2]).registerIngester(accounts[accounts.length - 1].address, message, nonce, sig2);
        
        // check all new incoming groups get allocated to the new ingester
        for (let i = maxNumberOfGroups; i < maxNumberOfGroups + 10; i++) {
            await groupManagerFacet.connect(contractOwner).addGroup(`group${i}`);
            const group = await groupManagerFacet.getGroup(`group${i}`);
            expect(group.isAdded).to.be.true;
            expect(group.ingesterAddresses).to.include(accounts[accounts.length -1].address);
            expect(group.ingesterAddresses.length <= maxIngestersPerGroup)

            let newIngester = await groupManagerFacet.getIngesterWithGroups(accounts[accounts.length -1].address);
            expect(newIngester.assignedGroups).to.include(`group${i}`);
        }
    });

    it("should add unaloccated groups to newly registered ingester if capacity allows", async () => {
        let maxGroupsPerCluster = numIngesters * maxGroupsPerIngester;

        // Add maximum groups possible
        let totalAssignedGroups: string[] = [];
        for (let i = 0; i < maxGroupsPerCluster; i++) {
            await groupManagerFacet.connect(contractOwner).addGroup(`group${i}`);
            const group = await groupManagerFacet.getGroup(`group${i}`);
            totalAssignedGroups.push(`group${i}`);
            expect(group.isAdded).to.be.true;
            expect(group.ingesterAddresses.length <= maxIngestersPerGroup)
        }

        let ingesterToRemove = await groupManagerFacet.getIngesterWithGroups(ingesters[0].address);
        let ingesterRemovedAssignedGroups: string[] = ingesterToRemove.assignedGroups;

        //Most expensive action in the entire flow, time this for reference
        await registryFacet.connect(ingesterToController[ingesters[0].address]).unRegisterIngester(ingesters[0].address);
        await groupManagerFacet.connect(ingesterToController[ingesters[0].address]).distributeUnallocatedGroups();

        expect(groupManagerFacet.getIngesterWithGroups(ingesters[0].address)).to.be.revertedWith("Ingester does not exist.");

        //Grab unallocated groups and check if they are correctly unallocated and don't overlap with allocated groups
        let unAllocatedGroupsBeforeRegistration = await groupManagerFacet.getUnallocatedGroups();
        
        //register Ingester again and check if the unallocated groups get allocated again
        let hash = await registryFacet.hash(ingesters[0].address, message, nonce);
        const sig = await ingesterToController[ingesters[0].address].signMessage(ethers.utils.arrayify(hash));
        await registryFacet.connect(ingesterToController[ingesters[0].address]).registerIngester(ingesters[0].address, message, nonce, sig);
        //Distribute groups after registration
        let ingesterBeforeDistribution = await groupManagerFacet.getIngesterWithGroups(ingesters[0].address);
        let distributeTx = await groupManagerFacet.connect(ingesterToController[ingesters[0].address]).distributeGroupsToIngester(ingesters[0].address);
        let ingesterAfterDistribution = await groupManagerFacet.getIngesterWithGroups(ingesters[0].address);

        let unAllocatedGroupsAfterRegistration = await groupManagerFacet.getUnallocatedGroups();
       
        expect(unAllocatedGroupsAfterRegistration.length < unAllocatedGroupsBeforeRegistration.length);
        
        //Check if unallocated groups were distributed and events were triggered
        let cluster = await groupManagerFacet.getCluster(ingesterBeforeDistribution.clusterId);
        let clusterRemainingCapacityBeforeDistribution = BigNumber.from(cluster.clusterRemainingCapacity).toNumber();
        if (unAllocatedGroupsBeforeRegistration.length > 0) {
            expect(distributeTx).to.emit(groupManagerFacet, "RemoveUnallocatedGroup")
            .and.to.emit(groupManagerFacet, "GroupDistributed");
        } 

        //make sure that the unallocated groups - clusterRemainingCapacity = the new amount of unallocated groups
        expect((unAllocatedGroupsBeforeRegistration.length - clusterRemainingCapacityBeforeDistribution) == unAllocatedGroupsAfterRegistration.length);
    });

    it("should add possible unaloccated groups to newly registered ingester even when under capacity", async () => {
        let maxGroupsPerCluster = numIngesters * maxGroupsPerIngester;
        let indIngesterToRemove = 0;
        let indIngesterToRemove2 = ingesters.length - 1;

        // Add maximum groups possible
        let totalAssignedGroups: string[] = [];
        for (let i = 0; i < maxAllocatableGroups; i++) {
            await groupManagerFacet.connect(contractOwner).addGroup(`group${i}`);
            const group = await groupManagerFacet.getGroup(`group${i}`);
            totalAssignedGroups.push(`group${i}`);
            expect(group.isAdded).to.be.true;
            expect(group.ingesterAddresses.length <= maxIngestersPerGroup)
        }
        
        //Most expensive action in the entire flow, time this for reference
        await registryFacet.connect(ingesterToController[ingesters[indIngesterToRemove].address]).unRegisterIngester(ingesters[indIngesterToRemove].address);
        await registryFacet.connect(ingesterToController[ingesters[indIngesterToRemove2].address]).unRegisterIngester(ingesters[indIngesterToRemove2].address);
        await groupManagerFacet.distributeUnallocatedGroups();
        await groupManagerFacet.distributeUnallocatedGroups();

        expect(groupManagerFacet.getIngesterWithGroups(ingesters[indIngesterToRemove].address)).to.be.revertedWith("Ingester does not exist.");
        expect(groupManagerFacet.getIngesterWithGroups(ingesters[indIngesterToRemove2].address)).to.be.revertedWith("Ingester does not exist.");

        //Grab unallocated groups and check if they are correctly unallocated and don't overlap with allocated groups
        let unAllocatedGroupsBeforeRegistration = await groupManagerFacet.getUnallocatedGroups();
        
        //register Ingester again and check if the unallocated groups get allocated again
        let hash = await registryFacet.hash(ingesters[indIngesterToRemove].address, message, nonce);
        const sig = await ingesterToController[ingesters[indIngesterToRemove].address].signMessage(ethers.utils.arrayify(hash));
        await registryFacet.connect(ingesterToController[ingesters[indIngesterToRemove].address]).registerIngester(ingesters[indIngesterToRemove].address, message, nonce, sig);

        let hash2 = await registryFacet.hash(ingesters[indIngesterToRemove2].address, message, nonce);
        const sig2 = await ingesterToController[ingesters[indIngesterToRemove2].address].signMessage(ethers.utils.arrayify(hash2));
        await registryFacet.connect(ingesterToController[ingesters[indIngesterToRemove2].address]).registerIngester(ingesters[indIngesterToRemove2].address, message, nonce, sig2);
        
        //Distribute groups after registration for first ingester
        let ingesterBeforeDistribution1 = await groupManagerFacet.getIngesterWithGroups(ingesters[indIngesterToRemove].address);
        let distributeTx = await groupManagerFacet.connect(ingesterToController[ingesters[indIngesterToRemove].address]).distributeGroupsToIngester(ingesters[indIngesterToRemove].address);
        let ingesterAfterDistribution1 = await groupManagerFacet.getIngesterWithGroups(ingesters[indIngesterToRemove].address);

        //Distribute groups after registration for second ingester
        let ingesterBeforeDistribution2 = await groupManagerFacet.getIngesterWithGroups(ingesters[indIngesterToRemove2].address);
        let distributeTx2 = await groupManagerFacet.connect(ingesterToController[ingesters[indIngesterToRemove2].address]).distributeGroupsToIngester(ingesters[indIngesterToRemove2].address);
        let ingesterAfterDistribution2 = await groupManagerFacet.getIngesterWithGroups(ingesters[indIngesterToRemove2].address);

        let unAllocatedGroupsAfterRegistration = await groupManagerFacet.getUnallocatedGroups();
       
        expect(unAllocatedGroupsAfterRegistration.length < unAllocatedGroupsBeforeRegistration.length);
        
        //Check if events were triggered
        if (unAllocatedGroupsBeforeRegistration.length > 0) {
            expect(distributeTx).to.emit(groupManagerFacet, "RemoveUnallocatedGroup")
            .and.to.emit(groupManagerFacet, "GroupDistributed");
        } 

        //unallocatedGroups should now be empty
        expect(unAllocatedGroupsAfterRegistration.length == 0);

        //make sure all unallocated groups are included in the newly registered ingester
        const differenceBeforeAfterIngester1 = ingesterAfterDistribution1.assignedGroups.filter(group => !ingesterBeforeDistribution1.assignedGroups.includes(group));
        const differenceBeforeAfterIngester2 = ingesterAfterDistribution2.assignedGroups.filter(group => !ingesterBeforeDistribution2.assignedGroups.includes(group));
        let allocatedGroups = differenceBeforeAfterIngester1.concat(differenceBeforeAfterIngester2);

        const allGroupsAssigned: boolean = unAllocatedGroupsBeforeRegistration.every(group => allocatedGroups.includes(group));
        expect(allGroupsAssigned).to.be.true;
    });

    describe("Manage Groups With Replication", function () {
        const newMaxIngestersPerGroup = 3;

        let numGroupsWithReplication: number;
        beforeEach(async function () {
            numGroupsWithReplication = (maxAllocatableGroups / newMaxIngestersPerGroup);
            // add replication of 3
            await groupManagerFacet.setMaxIngestersPerGroup(newMaxIngestersPerGroup);
        });

        it("should have set maxNumberIngesterPerGroup correctly", async () => {
            let newMaxNumberIngesterPerGroup = BigNumber.from(await groupManagerFacet.getMaxIngestersPerGroup()).toNumber();
            expect(newMaxNumberIngesterPerGroup).to.equal(newMaxIngestersPerGroup);
        });
    
        it("should add a new group to all ingesters within cluster", async () => {
            let addGroupTx = await groupManagerFacet.connect(contractOwner).addGroup("group1");
            const group = await groupManagerFacet.getGroup("group1");
            let groupUserNameIndex = BigNumber.from(group.groupUsernameIndex).toNumber();
            let groupUsernames = await groupManagerFacet.getGroupUsernameByIndex(groupUserNameIndex);
            expect(addGroupTx).to.emit(groupManagerFacet, "GroupDistributed").withArgs(group.clusterId, "group1")
                .and.to.emit(groupManagerFacet, "GroupAdded").withArgs("group1");
            expect(group.isAdded).to.be.true;
            expect(groupUsernames == "group1");
            
            expect(group.ingesterAddresses.length == newMaxIngestersPerGroup);
            
            //check groups have been added to all ingesters
            for (let i = 0; i < group.ingesterAddresses.length; i++) {
                let ingester = await groupManagerFacet.getIngesterWithGroups(group.ingesterAddresses[i]);
                expect(ingester.assignedGroups).to.include("group1");
            }

        });

        it("should remove an existing group", async () => {
            await groupManagerFacet.connect(contractOwner).addGroup("group1");
            const groupAfterAddition = await groupManagerFacet.getGroup("group1");

            expect(await groupManagerFacet.connect(contractOwner).removeGroup("group1")) //GroupRemovedFromIngester
            .to.emit(groupManagerFacet, "GroupRemovedFromIngester").withArgs(ingesters[0].address, "group1")
            .and.to.emit(groupManagerFacet, "GroupRemoved").withArgs("group1");
            const groupAfterRemoval = await groupManagerFacet.getGroup("group1");
            expect(groupAfterRemoval.isAdded).to.be.false;
            expect(groupAfterRemoval.ingesterAddresses.length == 0);

            for (let i = 0; i < groupAfterAddition.ingesterAddresses.length; i++) {
                let ingester = await groupManagerFacet.getIngesterWithGroups(groupAfterAddition.ingesterAddresses[i]);
                expect(ingester.assignedGroups).not.include("group1");
            }

        });

        it("should distribute to ingesters when groups are added", async () => {
            //each ingester should have at least 33 groups
            // check group assignement are within constraints
            for (let i = 0; i < numGroupsWithReplication; i++) {
                await groupManagerFacet.connect(contractOwner).addGroup(`group${i}`);
                const group = await groupManagerFacet.getGroup(`group${i}`);
                expect(group.isAdded).to.be.true;
                expect(group.ingesterAddresses.length <= newMaxIngestersPerGroup);
            }
            
            await checkClusterIsWithinConstraints(groupManagerFacet, registryFacet);
        });

        it("should distribute to ingesters when groups are added", async () => {
            //each ingester should have at least 33 groups
            // check group assignement are within constraints
            for (let i = 0; i < numGroupsWithReplication; i++) {
                await groupManagerFacet.connect(contractOwner).addGroup(`group${i}`);
                const group = await groupManagerFacet.getGroup(`group${i}`);
                expect(group.isAdded).to.be.true;
                expect(group.ingesterAddresses.length <= newMaxIngestersPerGroup);
            }
            
            await checkClusterIsWithinConstraints(groupManagerFacet, registryFacet);
        });

        it("should revert when attempting to distribute more groups than the maxCapacity constraints", async () => {
            let clusterIds = await groupManagerFacet.getClusters();
            let getMaxGroupsPerIngester = BigNumber.from(await groupManagerFacet.getMaxGroupsPerIngester()).toNumber();
            let maxClusterSize = BigNumber.from(await groupManagerFacet.getMaxClusterSize()).toNumber();
            let getMaxIngestersPerGroup = BigNumber.from(await groupManagerFacet.getMaxIngestersPerGroup()).toNumber();
    
            let totalGroupsConstraint = (clusterIds.length * maxClusterSize * getMaxGroupsPerIngester) / getMaxIngestersPerGroup;
            
            for (let i = 0; i < totalGroupsConstraint; i++) {
                if(totalGroupsConstraint-1 == i) {
                    expect(await groupManagerFacet.connect(contractOwner).addGroup(`group${i}`)).to.revertedWith("No more ingesters available to add groups to");
                } else {
                    await groupManagerFacet.connect(contractOwner).addGroup(`group${i}`);
                    const group = await groupManagerFacet.getGroup(`group${i}`);
                    expect(group.isAdded).to.be.true;
                    expect(group.ingesterAddresses.length <= getMaxIngestersPerGroup)
                }
            }
        });

        it("should not add groups to unAllocated storage if ingester is removed while there is replication", async () => {
            // check group assignement are within constraints
            let totalAssignedGroups: string[] = [];
            for (let i = 0; i < numGroupsWithReplication; i++) {
                await groupManagerFacet.connect(contractOwner).addGroup(`group${i}`);
                const group = await groupManagerFacet.getGroup(`group${i}`);
                totalAssignedGroups.push(`group${i}`);
                expect(group.isAdded).to.be.true;
                expect(group.ingesterAddresses.length <= newMaxIngestersPerGroup)
            }
    
            let ingesterToRemove = await groupManagerFacet.getIngesterWithGroups(ingesters[0].address);
            let ingestersAllocatedCluster = BigNumber.from(ingesterToRemove.clusterId).toNumber();
            let maxGroupsPerIngesterBeforeUnregistering = await getClusterMaxGroupsPerIngester(groupManagerFacet, ingestersAllocatedCluster);
    
            let ingesterRemovedAssignedGroups: string[] = ingesterToRemove.assignedGroups;
    
            await registryFacet.connect(ingesterToController[ingesters[0].address]).unRegisterIngester(ingesters[0].address);
            await groupManagerFacet.distributeUnallocatedGroups();

            let clusterId = BigNumber.from(ingesterToRemove.clusterId).toNumber();
            let maxGroupsPerIngesterAfterUnregistering = await getClusterMaxGroupsPerIngester(groupManagerFacet, clusterId);
            
            expect(maxGroupsPerIngesterAfterUnregistering > maxGroupsPerIngesterBeforeUnregistering);
    
            //Get the new assigned groups after unregistration
            let totalAssignedGroupsAfterUnregistration: string[] = []
            let remainingIngesters: SignerWithAddress[] = ingesters.slice(1);
            for (let j = 0; j < remainingIngesters.length; j++) {
                let ingester = await groupManagerFacet.getIngesterWithGroups(remainingIngesters[j].address);
                totalAssignedGroupsAfterUnregistration = totalAssignedGroupsAfterUnregistration.concat(ingester.assignedGroups);
                expect(ingester.assignedGroups.length > maxGroupsPerIngesterBeforeUnregistering);
                expect(ingester.assignedGroups.length < maxGroupsPerIngesterAfterUnregistering);
            }
    
            //Grab unallocated groups and check if they are correctly unallocated and don't overlap with allocated groups
            let unAllocatedGroups = await groupManagerFacet.getUnallocatedGroups();
            expect(unAllocatedGroups.length == 0);
    
            //check if ingester was also removed from the cluster
            let cluster = await groupManagerFacet.getCluster(ingestersAllocatedCluster);
            expect(cluster.ingesterAddresses).not.include(ingesterToRemove.ingesterAddress);
        });
    });
    
});

