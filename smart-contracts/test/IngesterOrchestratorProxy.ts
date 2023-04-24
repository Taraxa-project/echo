import { ethers } from "hardhat";
import { Signer, Contract } from "ethers";
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import { expect } from "chai";
import { BigNumber } from 'ethers';
import { IngesterRegistry } from '../typechain-types/contracts/IngesterOrchestratorProxy/IngesterRegistry';
import { IngesterDataGathering } from '../typechain-types/contracts/IngesterOrchestratorProxy/IngesterDataGathering';
import { IngesterGroupManager } from '../typechain-types/contracts/IngesterOrchestratorProxy/IngesterGroupManager';
import { IngesterProxy } from '../typechain-types/contracts/IngesterOrchestratorProxy/IngesterProxy';
import { IIngesterGroupManager } from '../typechain-types/contracts/IngesterOrchestratorProxy/IngesterGroupManager';

import cluster from "cluster";

interface IngesterControllerMapping {
    [ingesterAddress: string]: SignerWithAddress;
  }

interface IngesterToGroups {
    [ingesterAddress: string]: string[];
  }

type GroupComparisonResult = {
matchingGroups: string[];
nonMatchingGroups: string[];
};
  
function compareGroups(
ingesterRemovedAssignedGroups: string[],
totalAssignedGroups: string[]
): GroupComparisonResult {
const matchingGroups: string[] = [];
const nonMatchingGroups: string[] = [];

for (const group of ingesterRemovedAssignedGroups) {
    if (totalAssignedGroups.includes(group)) {
    matchingGroups.push(group);
    } else {
    nonMatchingGroups.push(group);
    }
}

return {
    matchingGroups,
    nonMatchingGroups,
};
}

async function getClusterGroups(ingesterProxy: IngesterProxy, cluster: IIngesterGroupManager.ClusterSlimStructOutput) {
    // Use map to transform the ingesterAddresses array into an array of ingester.assignedGroups Promises
    const assignedGroupsPromises = cluster.ingesterAddresses.map(async (ingesterAddress) => {
      const ingester = await ingesterProxy.getIngesterWithGroups(ingesterAddress);
      return ingester.assignedGroups;
    });
  
    // Use Promise.all to wait for all the Promises to resolve
    const allAssignedGroups = await Promise.all(assignedGroupsPromises);
  
    // Use reduce to concatenate all the assignedGroups arrays into a single array
    const clusterGroups = allAssignedGroups.reduce((acc, assignedGroups) => [...acc, ...assignedGroups], []);
    return clusterGroups;
}

async function getClusterMaxGroupsPerIngester(ingesterProxy: IngesterProxy, clusterId: number) {
    let clusterDetails = await ingesterProxy.getCluster(clusterId);
    let clusterGroupCount = BigNumber.from(clusterDetails.clusterGroupCount).toNumber();
    let clusterIngesterCount = BigNumber.from(clusterDetails.ingesterAddresses.length).toNumber();
    let maxGroupsPerIngesterAfterUnregistering = (clusterGroupCount + clusterIngesterCount - 1) / clusterIngesterCount;
    return maxGroupsPerIngesterAfterUnregistering
}

function allUnique(arr: number[]): boolean {
    const set = new Set(arr);
    return set.size === arr.length;
}
  

describe("IngesterOrchestratorProxy", () => {
  let accounts: SignerWithAddress[];
  let ingesterProxy: IngesterProxy;
  let ingesterRegistry: IngesterRegistry;
  let ingesterDataGathering: IngesterDataGathering;
  let ingesterGroupManager: IngesterGroupManager;
  let owner: SignerWithAddress;
  let ingester1: SignerWithAddress;
  let ingester2: SignerWithAddress;
  let ingester3: SignerWithAddress;
  let ingester4: SignerWithAddress;
  let ingester5: SignerWithAddress;
  let controller: SignerWithAddress;
  let controller2: SignerWithAddress;
  let controller3: SignerWithAddress;
  const message: string = 'hello';
  const nonce: number = 123;
  let maxIngesterPerGroup = 1;
  const maxClusterSize = 3;
  const maxGroupsPerIngester = 10;
  const zeroAddress = "0x0000000000000000000000000000000000000000";


  beforeEach(async () => {
    accounts = await ethers.getSigners();
    [owner, ingester1, ingester2, ingester3, ingester4, ingester5, controller, controller2, controller3] = await ethers.getSigners();
    const IngesterDataGathering = await ethers.getContractFactory("IngesterDataGathering", owner);
    const IngesterGroupManager = await ethers.getContractFactory("IngesterGroupManager", owner);
    const IngesterRegistry = await ethers.getContractFactory("IngesterRegistry", owner);
    ingesterDataGathering = await IngesterDataGathering.deploy();
    ingesterGroupManager = await IngesterGroupManager.deploy(maxClusterSize, maxGroupsPerIngester, maxIngesterPerGroup);
    ingesterRegistry = await IngesterRegistry.deploy();
    await ingesterDataGathering.deployed();
    await ingesterGroupManager.deployed();
    await ingesterRegistry.deployed();

    const IngesterProxy = await ethers.getContractFactory("IngesterProxy", owner);
    ingesterProxy = await IngesterProxy.deploy(ingesterGroupManager.address, ingesterRegistry.address, ingesterDataGathering.address);
    await ingesterProxy.deployed();

    await ingesterDataGathering.connect(owner).updateIngesterProxy(ingesterProxy.address);
    await ingesterGroupManager.connect(owner).updateIngesterProxy(ingesterProxy.address);
    await ingesterRegistry.connect(owner).updateIngesterProxy(ingesterProxy.address);
  });

  describe("OwnershipProxy", function () {
    it("should transfer ownership", async function () {
        const newOwner = ingester1.address;
        await expect(ingesterProxy.transferOwnership(newOwner)).to.emit(ingesterProxy, "OwnershipTransferred");

        expect(await ingesterProxy.owner()).to.equal(newOwner);
    });

    it("should not allow non-admin to transfer ownership", async function () {
        const newOwner = ingester1.address;

        let currentOwner = await ingesterProxy.owner();
    
        await expect(ingesterProxy.connect(ingester1).transferOwnership(newOwner)).to.be.revertedWith("Only admin can perform this action.");
    
        expect(await ingesterProxy.owner()).to.equal(await owner.getAddress());
    });

    it("should allocate admin role to contract creater", async function () {
        const DEFAULT_ADMIN_ROLE = await ingesterProxy.DEFAULT_ADMIN_ROLE();

        const adminCount = await ingesterProxy.getRoleMemberCount(DEFAULT_ADMIN_ROLE);
        const adminCountNum =  BigNumber.from(adminCount).toNumber()
        const adminMember = await ingesterProxy.getRoleMember(DEFAULT_ADMIN_ROLE, 0);
       
        expect(adminMember == owner.address);
    });
  });

  describe("Updating contract addresses", function () {
    it("should set a new ingester proxy address (IngesterDataGathering Contract) and emit an event ", async function () {
        const newProxyAddress = ingester1.address;
        await expect(ingesterDataGathering.updateIngesterProxy(newProxyAddress)).to.emit(ingesterDataGathering, "IngesterProxyAddressUpdated");

        expect(await ingesterDataGathering.ingesterProxyAddress()).to.equal(newProxyAddress);
    });

    it("should fail if setting a zero address as a new ingester proxy address (IngesterDataGathering Contract)", async function () {
        await expect(ingesterDataGathering.updateIngesterProxy(zeroAddress)).to.be.revertedWith("New ingester proxy address cannot be a zero address.");
    });

    it("should set a new ingester proxy address (IngesterGroupManager Contract) and emit an event ", async function () {
        const newProxyAddress = ingester1.address;
        await expect(ingesterGroupManager.updateIngesterProxy(newProxyAddress)).to.emit(ingesterGroupManager, "IngesterProxyAddressUpdated");

        expect(await ingesterGroupManager.ingesterProxyAddress()).to.equal(newProxyAddress);
    });

    it("should fail if setting a zero address as a new ingester proxy address (IngesterGroupManager Contract)", async function () {
        await expect(ingesterGroupManager.updateIngesterProxy(zeroAddress)).to.be.revertedWith("New ingester proxy address cannot be a zero address.");
    });

    it("should set a new ingester proxy address (IngesterRegistry Contract) and emit an event ", async function () {
        const newProxyAddress = ingester1.address;
        await expect(ingesterRegistry.updateIngesterProxy(newProxyAddress)).to.emit(ingesterRegistry, "IngesterProxyAddressUpdated");

        expect(await ingesterRegistry.ingesterProxyAddress()).to.equal(newProxyAddress);
    });

    it("should fail if setting a zero address as a new ingester proxy address (IngesterRegistry Contract)", async function () {
        await expect(ingesterRegistry.updateIngesterProxy(zeroAddress)).to.be.revertedWith("New ingester proxy address cannot be a zero address.");
    });

    it("should set a new group manager contract address in the ingester proxy contract and emit an event", async function () {
        const newProxyAddress = ingester1.address;
        await expect(ingesterProxy.updateGroupManagerContract(newProxyAddress)).to.emit(ingesterProxy, "GroupManagerContractAddressUpdated");

        expect(await ingesterProxy.groupManagerContractAddress()).to.equal(newProxyAddress);
    });

    it("should fail if setting a zero address as a new group manager contract address in the ingester proxy contract", async function () {
        await expect(ingesterProxy.updateGroupManagerContract(zeroAddress)).to.be.revertedWith("New group manager contract address cannot be a zero address.");
    });

    it("should set a new registration contract address in the ingester proxy contract and emit an event", async function () {
        const newProxyAddress = ingester1.address;
        await expect(ingesterProxy.updateRegistrationContract(newProxyAddress)).to.emit(ingesterProxy, "RegistrationContractAddressUpdated");

        expect(await ingesterProxy.registrationContractAddress()).to.equal(newProxyAddress);
    });

    it("should fail if setting a zero address as a new registration contract contract address in the ingester proxy contract", async function () {
        await expect(ingesterProxy.updateRegistrationContract(zeroAddress)).to.be.revertedWith("New registration contract address cannot be a zero address.");
    });

    it("should set a new data gathering contract address in the ingester proxy contract and emit an event", async function () {
        const newProxyAddress = ingester1.address;
        await expect(ingesterProxy.updateDataGatheringContract(newProxyAddress)).to.emit(ingesterProxy, "DataGatheringContractAddressUpdated");

        expect(await ingesterProxy.dataGatheringContractAddress()).to.equal(newProxyAddress);
    });

    it("should fail if setting a zero address as a new registration contract contract address in the ingester proxy contract", async function () {
        await expect(ingesterProxy.updateRegistrationContract(zeroAddress)).to.be.revertedWith("New registration contract address cannot be a zero address.");
    });
  });

  describe("roleCreationRegistry", function () {
    it("should allocate admin role to contract creator", async function () {
        const DEFAULT_ADMIN_ROLE = await ingesterRegistry.DEFAULT_ADMIN_ROLE();

        const adminCount = await ingesterRegistry.getRoleMemberCount(DEFAULT_ADMIN_ROLE);
        const adminCountNum =  BigNumber.from(adminCount).toNumber()
        const adminMember = await ingesterRegistry.getRoleMember(DEFAULT_ADMIN_ROLE, 0);
       
        expect(adminMember == owner.address);
    });
  });

  describe("roleCreationDataGathering", function () {
    it("should allocate admin role to contract creator", async function () {
        const DEFAULT_ADMIN_ROLE = await ingesterDataGathering.DEFAULT_ADMIN_ROLE();

        const adminCount = await ingesterDataGathering.getRoleMemberCount(DEFAULT_ADMIN_ROLE);
        const adminCountNum =  BigNumber.from(adminCount).toNumber()
        const adminMember = await ingesterDataGathering.getRoleMember(DEFAULT_ADMIN_ROLE, 0);
       
        expect(adminMember == owner.address);
    });
  });

  describe("roleCreationGroupManager", function () {
    it("should allocate admin role to contract creator", async function () {
        const DEFAULT_ADMIN_ROLE = await ingesterGroupManager.DEFAULT_ADMIN_ROLE();

        const adminCount = await ingesterGroupManager.getRoleMemberCount(DEFAULT_ADMIN_ROLE);
        const adminCountNum =  BigNumber.from(adminCount).toNumber()
        const adminMember = await ingesterGroupManager.getRoleMember(DEFAULT_ADMIN_ROLE, 0);
       
        expect(adminMember == owner.address);
    });
  });

  describe("registerIngester", function () {
    it("should register a new ingester", async function () {
        const controller = ingester2;

        let hash = await ingesterProxy.hash(ingester1.address, message, nonce);

        const sig = await controller.signMessage(ethers.utils.arrayify(hash));
        expect(ingesterProxy.connect(controller).registerIngester(ingester1.address, message, nonce, sig))
        .to.emit(ingesterProxy, "IngesterRegistered")
        .withArgs(ingester1.address, controller.address);
    });

    it("should fail registering a new ingester when sig is incorrect", async function () {
        const controller = ingester2;

        const incorrectMessage = 'bye';

        let hash = await ingesterProxy.hash(ingester1.address, message, nonce);
        const sig = await controller.signMessage(ethers.utils.arrayify(hash));

        expect(ingesterProxy.connect(controller).registerIngester(ingester1.address, incorrectMessage, nonce, sig)).to.be.revertedWith("Invalid signature.");
    });

    it("should create an ingester role when registering", async function () {
        //Register an ingester
        const controller = ingester2;
        
        let hash = await ingesterProxy.hash(ingester1.address, message, nonce);
        const sig = await controller.signMessage(ethers.utils.arrayify(hash));
        
        await ingesterProxy.connect(controller).registerIngester(ingester1.address, message, nonce, sig)
        
        //Fetch Ingester Role addresses
        const isRegisteredIngester = await ingesterProxy.isRegisteredIngester(ingester1.address);
        expect(isRegisteredIngester == false);
    });

    it("should fail when attempting to re-register the same ingester", async function () {
        //Register an ingester
        const controller = ingester2;
        
        let hash = await ingesterProxy.hash(ingester1.address, message, nonce);
        const sig = await controller.signMessage(ethers.utils.arrayify(hash));
        
        await ingesterProxy.connect(controller).registerIngester(ingester1.address, message, nonce, sig);
        
        expect(ingesterProxy.connect(controller).registerIngester(ingester1.address, message, nonce, sig)).to.be.revertedWith("Ingestor already registered.");
    });

    it("should fail when attempting to re-register the same ingester with a different controller account", async function () {
        //Register an ingester
        const controller = ingester2;
        
        let hash = await ingesterProxy.hash(ingester1.address, message, nonce);
        
        const sig = await controller.signMessage(ethers.utils.arrayify(hash));
        
        await ingesterProxy.connect(controller).registerIngester(ingester1.address, message, nonce, sig);
        
        expect(ingesterProxy.connect(ingester3).registerIngester(ingester1.address, message, nonce, sig)).to.be.revertedWith("Ingestor already registered.");
    });

    it("should be able to register multiple ingester accounts under the same controller account", async function () {
        //Register an ingester
        const controller = ingester2;
        
        let hash = await ingesterProxy.hash(ingester1.address, message, nonce);
        
        const sig = await controller.signMessage(ethers.utils.arrayify(hash));
        
        expect(ingesterProxy.connect(controller).registerIngester(ingester1.address, message, nonce, sig)).to.emit(ingesterProxy, "IngesterRegistered")
        .withArgs(ingester1.address, controller.address);

        //register other ingester accounts under the same controller address
        expect(ingesterProxy.connect(controller).registerIngester(ingester3.address, message, nonce, sig)).to.emit(ingesterProxy, "IngesterRegistered")
        .withArgs(ingester3.address, controller.address);
        expect(ingesterProxy.connect(controller).registerIngester(ingester4.address, message, nonce, sig)).to.emit(ingesterProxy, "IngesterRegistered")
        .withArgs(ingester4.address, controller.address);
    });

    it("should be able to unregister ingester accounts after registering and renounce role", async function () {
        //Register an ingester
        const controller = ingester2;
        
        let hash = await ingesterProxy.hash(ingester1.address, message, nonce);
        
        const sig = await controller.signMessage(ethers.utils.arrayify(hash));
        
        expect(ingesterProxy.connect(controller).registerIngester(ingester1.address, message, nonce, sig)).to.emit(ingesterProxy, "IngesterRegistered")
        .withArgs(ingester1.address, controller.address);

        //register other ingester accounts under the same controller address
        expect(ingesterProxy.connect(controller).unRegisterIngester(ingester1.address)).to.emit(ingesterProxy, "IngesterUnRegistered")
            .withArgs(controller.address, ingester1.address);

        expect(ingesterProxy.getIngesterWithGroups(ingester1.address)).to.be.revertedWith("Ingester does not exist.");
        
        //Fetch Ingester Role addresses
        const isRegisteredIngester = await ingesterProxy.isRegisteredIngester(ingester1.address);
        expect(isRegisteredIngester == false);
    });

    it("should add ingester to cluster when registering a new ingester", async function () {
        //Register an ingester
        const controller = ingester2;
        
        let hash = await ingesterProxy.hash(ingester1.address, message, nonce);
        const sig = await controller.signMessage(ethers.utils.arrayify(hash));
        
        expect(await ingesterProxy.connect(controller).registerIngester(ingester1.address, message, nonce, sig)).to.emit(ingesterProxy, "IngesterAddedToCluster").withArgs(ingester1.address, 0);
    });

    it("should add ingester to additional cluster when more than maxClusterSize is reached", async function () {
        //Register an ingester
        let accounts: SignerWithAddress[] = await ethers.getSigners();
        let ingesters: SignerWithAddress[] = [];
        let numIngesters = 10;
        let ingesterToController: IngesterControllerMapping = {}
        let currentClusterCount = 0;

        for (let i = 1; i <= numIngesters; i++ ) {
            let hash = await ingesterProxy.hash(accounts[i].address, message, nonce);
            const sig = await accounts[i-1].signMessage(ethers.utils.arrayify(hash));
            if (i <= maxClusterSize) {
                expect(await ingesterProxy.connect(accounts[i-1]).registerIngester(accounts[i].address, message, nonce, sig)).to.emit(ingesterProxy, "IngesterAddedToCluster").withArgs(accounts[i].address, currentClusterCount);
            } else {
                //increment cluster count
                i == maxClusterSize + 1 && currentClusterCount++;
                expect(await ingesterProxy.connect(accounts[i-1]).registerIngester(accounts[i].address, message, nonce, sig)).to.emit(ingesterProxy, "IngesterAddedToCluster").withArgs(accounts[i].address, currentClusterCount);
            }
        }
    });

  });

  describe("Manage Groups", function () {
    let  addedGroups: string[] = [];
    let ingesterToController: IngesterControllerMapping = {}
    let accounts: SignerWithAddress[] = [];
    let numIngesters = 3;
    let numGroups = 30; //maxGroupsPerIngester * numIngesters;
    let ingesters: SignerWithAddress[] = [];
    let numIngestersToRemove = 2;
    beforeEach(async function () {

        accounts = await ethers.getSigners();
        ingesters = [];

        for (let i = 1; i <= numIngesters; i++ ) {
            let hash = await ingesterProxy.hash(accounts[i].address, message, nonce);
            const sig = await accounts[i-1].signMessage(ethers.utils.arrayify(hash));
            await ingesterProxy.connect(accounts[i-1]).registerIngester(accounts[i].address, message, nonce, sig);
            ingesterToController[accounts[i].address] = accounts[i-1];
            ingesters.push(accounts[i]);
        }
    });

    it("should set maxNumberIngesterPerGroup correctly with deployment", async () => {
        const test = await ingesterProxy.getMaxNumberIngesterPerGroup();
        expect(await ingesterProxy.getMaxNumberIngesterPerGroup()).to.equal(maxIngesterPerGroup);
    });
    
    it("should set maxNumberIngesterPerGroup", async () => {
        expect(await ingesterProxy.connect(owner).setMaxNumberIngesterPerGroup(10)).to.emit(ingesterProxy, "SetNewMaxIngesterPerGroup");
        let newMaxNumberIngesterPerGroup = BigNumber.from(await ingesterProxy.getMaxNumberIngesterPerGroup()).toNumber();
        expect(newMaxNumberIngesterPerGroup).to.equal(10);
    });

    it("should add a new group", async () => {
        expect(await ingesterProxy.connect(owner).addGroup("group1")).to.emit(ingesterProxy, "GroupAdded").withArgs("group1");
        const group = await ingesterProxy.getGroup("group1");
        let groupUserNameIndex = BigNumber.from(group.groupUsernameIndex).toNumber();
        let groupUsernames = await ingesterProxy.getGroupUsernameByIndex(groupUserNameIndex);
        expect(group.isAdded).to.be.true;
        expect(groupUsernames == "group1");
    });

    it("should remove an existing group", async () => {
        await ingesterProxy.connect(owner).addGroup("group1");

        expect(await ingesterProxy.connect(owner).removeGroup("group1")) //GroupRemovedFromIngester
        .to.emit(ingesterProxy, "GroupRemovedFromIngester").withArgs(ingester1.address, "group1")
        .and.to.emit(ingesterProxy, "GroupRemoved").withArgs("group1");
        const group = await ingesterProxy.getGroup("group1");
        expect(group.isAdded).to.be.false;
    });

    it("should distribute to ingesters when groups are added", async () => {
        //each ingester should have at least 33 groups
        // check group assignement are within constraints
        for (let i = 0; i < numGroups; i++) {
            await ingesterProxy.connect(owner).addGroup(`group${i}`);
            const group = await ingesterProxy.getGroup(`group${i}`);
            expect(group.isAdded).to.be.true;
            expect(group.ingesterAddresses.length <= maxIngesterPerGroup)
            
        }

        //check each cluster is within constraints
        let clusterIds = await ingesterProxy.getClusters();
        let getMaxGroupsPerIngester = BigNumber.from(await ingesterProxy.getMaxGroupsPerIngester()).toNumber();
        for (let i = 0; i < clusterIds.length; i++) {
            let cluster = await ingesterProxy.getCluster(clusterIds[i]);

            //Calculate the inner cluster contraint for this particular cluster
            let clusterGroupCount = BigNumber.from(cluster.clusterGroupCount).toNumber();
            let maxGroupsPerIngesterWithinCluster = Math.ceil((clusterGroupCount + cluster.ingesterAddresses.length -1) / cluster.ingesterAddresses.length);
            
            let ingesterToGroup: IngesterToGroups = {};
            let clusterGroups: string[] = []
            for (let j = 0; j < cluster.ingesterAddresses.length; j++ ) {
                let ingester = await ingesterProxy.getIngesterWithGroups(cluster.ingesterAddresses[j]);
                ingesterToGroup[ingester.ingesterAddress] = ingester.assignedGroups;
                clusterGroups = clusterGroups.concat(ingester.assignedGroups);
                
                for (let z = 0; z < ingester.assignedGroups.length; z++){
                    let group = await ingesterProxy.getGroup(ingester.assignedGroups[z]);
                    expect(group.ingesterAddresses).includes(cluster.ingesterAddresses[j]);
                } 
                expect(ingester.assignedGroups.length <= maxGroupsPerIngesterWithinCluster);
            }
            
            let maxNumberIngesterPerGroup = BigNumber.from(await ingesterProxy.getMaxNumberIngesterPerGroup()).toNumber();
            for (let j = 0; j < clusterGroups.length; j++ ) {
                let group = await ingesterProxy.getGroup(clusterGroups[j]);
                expect(group.ingesterAddresses.length <= maxNumberIngesterPerGroup);
            }
            //check that the amount of addresses per group abides by the global constraint
            expect(cluster.ingesterAddresses.length < maxClusterSize);
            //Check that the amount of groups is lower than the global constraint
            expect(clusterGroups.length < getMaxGroupsPerIngester);
        }

    });

    it("should revert when attempting to distribute more groups than the maxCapacity constraints", async () => {
        let clusterIds = await ingesterProxy.getClusters();
        let getMaxGroupsPerIngester = BigNumber.from(await ingesterProxy.getMaxGroupsPerIngester()).toNumber();
        let maxClusterSize = BigNumber.from(await ingesterProxy.getMaxClusterSize()).toNumber();

        let totalGroupsConstraint = clusterIds.length * maxClusterSize * getMaxGroupsPerIngester;
        
        for (let i = 0; i < totalGroupsConstraint; i++) {
            if(totalGroupsConstraint-1 == i) {
                expect(await ingesterProxy.connect(owner).addGroup(`group${i}`)).to.revertedWith("No more ingesters available to add groups to");
            } else {
                await ingesterProxy.connect(owner).addGroup(`group${i}`);
                const group = await ingesterProxy.getGroup(`group${i}`);
                expect(group.isAdded).to.be.true;
                expect(group.ingesterAddresses.length <= maxIngesterPerGroup)
            }
                
        }
    });

    it("should re-adjust groups when ingester is removed", async () => {
        let ingesterCount = BigNumber.from(await ingesterProxy.getIngesterCount()).toNumber();
        // let maxGroupsPerIngesterBeforeUnregistering = Math.ceil(numGroups / ingesterCount);

        // check group assignement are within constraints
        let totalAssignedGroups: string[] = [];
        for (let i = 0; i < numGroups; i++) {
            await ingesterProxy.connect(owner).addGroup(`group${i}`);
            const group = await ingesterProxy.getGroup(`group${i}`);
            totalAssignedGroups.push(`group${i}`);
            expect(group.isAdded).to.be.true;
            expect(group.ingesterAddresses.length <= maxIngesterPerGroup)
        }

        let ingesterToRemove = await ingesterProxy.getIngesterWithGroups(ingesters[0].address);
        let ingestersAllocatedCluster = BigNumber.from(ingesterToRemove.clusterId).toNumber();
        let maxGroupsPerIngesterBeforeUnregistering = await getClusterMaxGroupsPerIngester(ingesterProxy, ingestersAllocatedCluster);

        let ingesterRemovedAssignedGroups: string[] = ingesterToRemove.assignedGroups;

        await ingesterProxy.connect(ingesterToController[ingesters[0].address]).unRegisterIngester(ingesters[0].address);

        let clusterId = BigNumber.from(ingesterToRemove.clusterId).toNumber();
        let maxGroupsPerIngesterAfterUnregistering = await getClusterMaxGroupsPerIngester(ingesterProxy, clusterId);
        
        expect(maxGroupsPerIngesterAfterUnregistering > maxGroupsPerIngesterBeforeUnregistering);

        //Get the new assigned groups after unregistration
        let totalAssignedGroupsAfterUnregistration: string[] = []
        let remainingIngesters: SignerWithAddress[] = ingesters.slice(1);
        for (let j = 0; j < remainingIngesters.length; j++) {
            let ingester = await ingesterProxy.getIngesterWithGroups(remainingIngesters[j].address);
            totalAssignedGroupsAfterUnregistration = totalAssignedGroupsAfterUnregistration.concat(ingester.assignedGroups);
            expect(ingester.assignedGroups.length > maxGroupsPerIngesterBeforeUnregistering);
            expect(ingester.assignedGroups.length < maxGroupsPerIngesterAfterUnregistering);
        }

        //Grab unallocated groups and check if they are correctly unallocated and don't overlap with allocated groups
        let unAllocatedGroups = await ingesterProxy.getUnallocatedGroups();
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
        let cluster = await ingesterProxy.getCluster(ingestersAllocatedCluster);
        expect(cluster.ingesterAddresses).not.include(ingesterToRemove.ingesterAddress);
    });

    it("should re-adjust groups when multiple ingesters are removed", async () => {
        // check group assignement are within constraints
        for (let i = 0; i < numGroups; i++) {
            await ingesterProxy.connect(owner).addGroup(`group${i}`);
            const group = await ingesterProxy.getGroup(`group${i}`);
            expect(group.isAdded).to.be.true;
            expect(group.ingesterAddresses.length <= maxIngesterPerGroup)
        }

        let ingestersRemaining = ingesters;
        for (let i = 0; i < numIngestersToRemove; i++) {
            let ingesterToRemove = await ingesterProxy.getIngesterWithGroups(ingesters[i].address);
            
            // _maxGroupsPerIngester = (numClusterGroups + numIngesters - 1) / numIngesters;
            let clusterId = BigNumber.from(ingesterToRemove.clusterId).toNumber();
            let maxGroupsPerIngesterBeforeUnregistering = await getClusterMaxGroupsPerIngester(ingesterProxy, clusterId);

            let ingesterRemovedAssignedGroups: string[] = ingesterToRemove.assignedGroups;
            
            await ingesterProxy.connect(ingesterToController[ingesters[i].address]).unRegisterIngester(ingesters[i].address);

            let maxGroupsPerIngesterAfterUnregistering = await getClusterMaxGroupsPerIngester(ingesterProxy, clusterId);

            expect(maxGroupsPerIngesterAfterUnregistering > maxGroupsPerIngesterBeforeUnregistering);

            // Remove the ingester from structure
            let slicerIndex = i == 0 ? 1 : i;
            ingestersRemaining = ingestersRemaining.slice(slicerIndex);

            // check i remaining ingesters contain all the groups that were removed 
            let totalAssignedGroupsAfterUnregistration: string[] = []
            for (let j = 0; j < ingestersRemaining.length; j++) {
                let ingester = await ingesterProxy.getIngesterWithGroups(ingestersRemaining[j].address);
                totalAssignedGroupsAfterUnregistration = totalAssignedGroupsAfterUnregistration.concat(ingester.assignedGroups);
                expect(ingester.assignedGroups.length > maxGroupsPerIngesterBeforeUnregistering);
                expect(ingester.assignedGroups.length < maxGroupsPerIngesterAfterUnregistering);
            }

            //Grab unallocated groups and check if they are correctly unallocated and don't overlap with allocated groups
            let unAllocatedGroups = await ingesterProxy.getUnallocatedGroups();
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
            await ingesterProxy.connect(owner).addGroup(`group${i}`);
            const group = await ingesterProxy.getGroup(`group${i}`);
            expect(group.isAdded).to.be.true;
            expect(group.ingesterAddresses.length <= maxIngesterPerGroup);
        }

        // use last available account as new test ingester to be registered
        let hash2 = await ingesterProxy.hash(accounts[accounts.length -1].address, message, nonce);
        const sig2 = await accounts[accounts.length - 2].signMessage(ethers.utils.arrayify(hash2));
        await ingesterProxy.connect(accounts[accounts.length - 2]).registerIngester(accounts[accounts.length - 1].address, message, nonce, sig2);
        
        // check all new incoming groups get allocated to the new ingester
        for (let i = maxNumberOfGroups; i < maxNumberOfGroups + 10; i++) {
            await ingesterProxy.connect(owner).addGroup(`group${i}`);
            const group = await ingesterProxy.getGroup(`group${i}`);
            expect(group.isAdded).to.be.true;
            expect(group.ingesterAddresses).to.include(accounts[accounts.length -1].address);
            expect(group.ingesterAddresses.length <= maxIngesterPerGroup)

            let newIngester = await ingesterProxy.getIngesterWithGroups(accounts[accounts.length -1].address);
            expect(newIngester.assignedGroups).to.include(`group${i}`);
        }
    });

    it("should add unaloccated groups to newly registered ingester if capacity allows", async () => {
        let maxGroupsPerCluster = numIngesters * maxGroupsPerIngester;

        // Add maximum groups possible
        let totalAssignedGroups: string[] = [];
        for (let i = 0; i < maxGroupsPerCluster; i++) {
            await ingesterProxy.connect(owner).addGroup(`group${i}`);
            const group = await ingesterProxy.getGroup(`group${i}`);
            totalAssignedGroups.push(`group${i}`);
            expect(group.isAdded).to.be.true;
            expect(group.ingesterAddresses.length <= maxIngesterPerGroup)
        }

        let ingesterToRemove = await ingesterProxy.getIngesterWithGroups(ingesters[0].address);
        let ingesterRemovedAssignedGroups: string[] = ingesterToRemove.assignedGroups;

        //Most expensive action in the entire flow, time this for reference
        await ingesterProxy.connect(ingesterToController[ingesters[0].address]).unRegisterIngester(ingesters[0].address);

        expect(ingesterProxy.getIngesterWithGroups(ingesters[0].address)).to.be.revertedWith("Ingester does not exist.");

        //Grab unallocated groups and check if they are correctly unallocated and don't overlap with allocated groups
        let unAllocatedGroupsBeforeRegistration = await ingesterProxy.getUnallocatedGroups();
        
        //register Ingester again and check if the unallocated groups get allocated again
        let hash = await ingesterProxy.hash(ingesters[0].address, message, nonce);
        const sig = await ingesterToController[ingesters[0].address].signMessage(ethers.utils.arrayify(hash));
        await ingesterProxy.connect(ingesterToController[ingesters[0].address]).registerIngester(ingesters[0].address, message, nonce, sig);
        //Distribute groups after registration
        let ingesterBeforeDistribution = await ingesterProxy.getIngesterWithGroups(ingesters[0].address);
        let distributeTx = await ingesterProxy.connect(ingesterToController[ingesters[0].address]).distributeGroups(ingesters[0].address);
        let ingesterAfterDistribution = await ingesterProxy.getIngesterWithGroups(ingesters[0].address);

        let unAllocatedGroupsAfterRegistration = await ingesterProxy.getUnallocatedGroups();
       
        expect(unAllocatedGroupsAfterRegistration.length < unAllocatedGroupsBeforeRegistration.length);
        
        //Check if unallocated groups were distributed and events were triggered
        let cluster = await ingesterGroupManager.getCluster(ingesterBeforeDistribution.clusterId);
        let clusterRemainingCapacityBeforeDistribution = BigNumber.from(cluster.clusterRemainingCapacity).toNumber();
        if (unAllocatedGroupsBeforeRegistration.length > 0) {
            expect(distributeTx).to.emit(ingesterProxy, "RemoveUnallocatedGroup")
            .and.to.emit(ingesterProxy, "GroupDistributed");
        } 

        //make sure that the unallocated groups - clusterRemainingCapacity = the new amount of unallocated groups
        expect((unAllocatedGroupsBeforeRegistration.length - clusterRemainingCapacityBeforeDistribution) == unAllocatedGroupsAfterRegistration.length);
        //unallocatedGroups should now be empty
        expect(unAllocatedGroupsAfterRegistration.length == 0);

        //make sure all unallocated groups are included in the newly registered ingester
        const allGroupsAssigned: boolean = unAllocatedGroupsBeforeRegistration.every(element => ingesterAfterDistribution.assignedGroups.includes(element));
        expect(allGroupsAssigned).to.be.true;
    });

    it("should add possible unaloccated groups to newly registered ingester even when under capacity", async () => {
        let maxGroupsPerCluster = numIngesters * maxGroupsPerIngester;
        let indIngesterToRemove = 0;
        let indIngesterToRemove2 = ingesters.length - 1;

        // Add maximum groups possible
        let totalAssignedGroups: string[] = [];
        for (let i = 0; i < maxGroupsPerCluster; i++) {
            await ingesterProxy.connect(owner).addGroup(`group${i}`);
            const group = await ingesterProxy.getGroup(`group${i}`);
            totalAssignedGroups.push(`group${i}`);
            expect(group.isAdded).to.be.true;
            expect(group.ingesterAddresses.length <= maxIngesterPerGroup)
        }
        
        let ingesterToRemove1 = await ingesterProxy.getIngesterWithGroups(ingesters[indIngesterToRemove].address);
        let ingesterToRemove2 = await ingesterProxy.getIngesterWithGroups(ingesters[indIngesterToRemove2].address);

        //Most expensive action in the entire flow, time this for reference
        await ingesterProxy.connect(ingesterToController[ingesters[indIngesterToRemove].address]).unRegisterIngester(ingesters[indIngesterToRemove].address);
        await ingesterProxy.connect(ingesterToController[ingesters[indIngesterToRemove2].address]).unRegisterIngester(ingesters[indIngesterToRemove2].address);

        expect(ingesterProxy.getIngesterWithGroups(ingesters[indIngesterToRemove].address)).to.be.revertedWith("Ingester does not exist.");
        expect(ingesterProxy.getIngesterWithGroups(ingesters[indIngesterToRemove2].address)).to.be.revertedWith("Ingester does not exist.");

        //Grab unallocated groups and check if they are correctly unallocated and don't overlap with allocated groups
        let unAllocatedGroupsBeforeRegistration = await ingesterProxy.getUnallocatedGroups();
        
        //register Ingester again and check if the unallocated groups get allocated again
        let hash = await ingesterProxy.hash(ingesters[indIngesterToRemove].address, message, nonce);
        const sig = await ingesterToController[ingesters[indIngesterToRemove].address].signMessage(ethers.utils.arrayify(hash));
        await ingesterProxy.connect(ingesterToController[ingesters[indIngesterToRemove].address]).registerIngester(ingesters[indIngesterToRemove].address, message, nonce, sig);

        let hash2 = await ingesterProxy.hash(ingesters[indIngesterToRemove2].address, message, nonce);
        const sig2 = await ingesterToController[ingesters[indIngesterToRemove2].address].signMessage(ethers.utils.arrayify(hash2));
        await ingesterProxy.connect(ingesterToController[ingesters[indIngesterToRemove2].address]).registerIngester(ingesters[indIngesterToRemove2].address, message, nonce, sig2);
        
        //Distribute groups after registration for first ingester
        let ingesterBeforeDistribution1 = await ingesterProxy.getIngesterWithGroups(ingesters[indIngesterToRemove].address);
        let distributeTx = await ingesterProxy.connect(ingesterToController[ingesters[indIngesterToRemove].address]).distributeGroups(ingesters[indIngesterToRemove].address);
        let ingesterAfterDistribution1 = await ingesterProxy.getIngesterWithGroups(ingesters[indIngesterToRemove].address);

        //Distribute groups after registration for second ingester
        let ingesterBeforeDistribution2 = await ingesterProxy.getIngesterWithGroups(ingesters[indIngesterToRemove2].address);
        let distributeTx2 = await ingesterProxy.connect(ingesterToController[ingesters[indIngesterToRemove2].address]).distributeGroups(ingesters[indIngesterToRemove2].address);
        let ingesterAfterDistribution2 = await ingesterProxy.getIngesterWithGroups(ingesters[indIngesterToRemove2].address);

        let unAllocatedGroupsAfterRegistration = await ingesterProxy.getUnallocatedGroups();
       
        expect(unAllocatedGroupsAfterRegistration.length < unAllocatedGroupsBeforeRegistration.length);
        
        //Check if events were triggered
        if (unAllocatedGroupsBeforeRegistration.length > 0) {
            expect(distributeTx).to.emit(ingesterProxy, "RemoveUnallocatedGroup")
            .and.to.emit(ingesterProxy, "GroupDistributed");
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
        let numGroupsWithReplication: number;
        beforeEach(async function () {
            maxIngesterPerGroup = 3;
            numGroupsWithReplication = (numGroups / maxIngesterPerGroup);
            // add replication of 3
            await ingesterProxy.setMaxNumberIngesterPerGroup(maxIngesterPerGroup);
        });

        it("should have set maxNumberIngesterPerGroup correctly", async () => {
            let newMaxNumberIngesterPerGroup = BigNumber.from(await ingesterProxy.getMaxNumberIngesterPerGroup()).toNumber();
            expect(newMaxNumberIngesterPerGroup).to.equal(maxIngesterPerGroup);
        });
    
        it("should add a new group to all ingesters within cluster", async () => {
            let addGroupTx = await ingesterProxy.connect(owner).addGroup("group1");
            const group = await ingesterProxy.getGroup("group1");
            let groupUserNameIndex = BigNumber.from(group.groupUsernameIndex).toNumber();
            let groupUsernames = await ingesterProxy.getGroupUsernameByIndex(groupUserNameIndex);
            expect(addGroupTx).to.emit(ingesterProxy, "GroupDistributed").withArgs(group.clusterId, "group1")
                .and.to.emit(ingesterProxy, "GroupAdded").withArgs("group1");
            expect(group.isAdded).to.be.true;
            expect(groupUsernames == "group1");
            
            expect(group.ingesterAddresses.length == maxIngesterPerGroup);
            
            //check groups have been added to all ingesters
            for (let i = 0; i < group.ingesterAddresses.length; i++) {
                let ingester = await ingesterProxy.getIngesterWithGroups(group.ingesterAddresses[i]);
                expect(ingester.assignedGroups).to.include("group1");
            }

        });
    
        it("should remove an existing group", async () => {
            await ingesterProxy.connect(owner).addGroup("group1");
            const groupAfterAddition = await ingesterProxy.getGroup("group1");

            expect(await ingesterProxy.connect(owner).removeGroup("group1")) //GroupRemovedFromIngester
            .to.emit(ingesterProxy, "GroupRemovedFromIngester").withArgs(ingester1.address, "group1")
            .and.to.emit(ingesterProxy, "GroupRemoved").withArgs("group1");
            const groupAfterRemoval = await ingesterProxy.getGroup("group1");
            expect(groupAfterRemoval.isAdded).to.be.false;
            expect(groupAfterRemoval.ingesterAddresses.length == 0);

            for (let i = 0; i < groupAfterAddition.ingesterAddresses.length; i++) {
                let ingester = await ingesterProxy.getIngesterWithGroups(groupAfterAddition.ingesterAddresses[i]);
                expect(ingester.assignedGroups).not.include("group1");
            }

        });

        it("should distribute to ingesters when groups are added", async () => {
            //each ingester should have at least 33 groups
            // check group assignement are within constraints
            for (let i = 0; i < numGroupsWithReplication; i++) {
                await ingesterProxy.connect(owner).addGroup(`group${i}`);
                const group = await ingesterProxy.getGroup(`group${i}`);
                expect(group.isAdded).to.be.true;
                expect(group.ingesterAddresses.length <= maxIngesterPerGroup);
            }
    
            //check each cluster is within constraints
            let clusterIds = await ingesterProxy.getClusters();
            let getMaxGroupsPerIngester = BigNumber.from(await ingesterProxy.getMaxGroupsPerIngester()).toNumber();
            for (let i = 0; i < clusterIds.length; i++) {
                let cluster = await ingesterProxy.getCluster(clusterIds[i]);
    
                //Calculate the inner cluster contraint for this particular cluster
                let clusterGroupCount = BigNumber.from(cluster.clusterGroupCount).toNumber();
                let maxGroupsPerIngesterWithinCluster = Math.ceil((clusterGroupCount + cluster.ingesterAddresses.length -1) / cluster.ingesterAddresses.length);
                
                let ingesterToGroup: IngesterToGroups = {};
                let clusterGroups: string[] = []
                for (let j = 0; j < cluster.ingesterAddresses.length; j++ ) {
                    let ingester = await ingesterProxy.getIngesterWithGroups(cluster.ingesterAddresses[j]);
                    ingesterToGroup[ingester.ingesterAddress] = ingester.assignedGroups;
                    clusterGroups = clusterGroups.concat(ingester.assignedGroups);
                    
                    for (let z = 0; z < ingester.assignedGroups.length; z++){
                        let group = await ingesterProxy.getGroup(ingester.assignedGroups[z]);
                        expect(group.ingesterAddresses).includes(cluster.ingesterAddresses[j]);
                    } 
                    expect(ingester.assignedGroups.length <= maxGroupsPerIngesterWithinCluster);
                }
                
                let maxNumberIngesterPerGroup = BigNumber.from(await ingesterProxy.getMaxNumberIngesterPerGroup()).toNumber();
                for (let j = 0; j < clusterGroups.length; j++ ) {
                    let group = await ingesterProxy.getGroup(clusterGroups[j]);
                    expect(group.ingesterAddresses.length <= maxNumberIngesterPerGroup);
                }
                //check that the amount of addresses per group abides by the global constraint
                expect(cluster.ingesterAddresses.length < maxClusterSize);
                //Check that the amount of groups is lower than the global constraint
                expect(clusterGroups.length < getMaxGroupsPerIngester);
            }
    
        });

        it("should revert when attempting to distribute more groups than the maxCapacity constraints", async () => {
            let clusterIds = await ingesterProxy.getClusters();
            let getMaxGroupsPerIngester = BigNumber.from(await ingesterProxy.getMaxGroupsPerIngester()).toNumber();
            let maxClusterSize = BigNumber.from(await ingesterProxy.getMaxClusterSize()).toNumber();
    
            let totalGroupsConstraint = (clusterIds.length * maxClusterSize * getMaxGroupsPerIngester) / maxIngesterPerGroup;
            
            for (let i = 0; i < totalGroupsConstraint; i++) {
                if(totalGroupsConstraint-1 == i) {
                    expect(await ingesterProxy.connect(owner).addGroup(`group${i}`)).to.revertedWith("No more ingesters available to add groups to");
                } else {
                    await ingesterProxy.connect(owner).addGroup(`group${i}`);
                    const group = await ingesterProxy.getGroup(`group${i}`);
                    expect(group.isAdded).to.be.true;
                    expect(group.ingesterAddresses.length <= maxIngesterPerGroup)
                }
                    
            }
        });

        it("should not add groups to unAllocated storage if ingester is removed while there is replication", async () => {
            let ingesterCount = BigNumber.from(await ingesterProxy.getIngesterCount()).toNumber();
            // let maxGroupsPerIngesterBeforeUnregistering = Math.ceil(numGroups / ingesterCount);
    
            // check group assignement are within constraints
            let totalAssignedGroups: string[] = [];
            for (let i = 0; i < numGroupsWithReplication; i++) {
                await ingesterProxy.connect(owner).addGroup(`group${i}`);
                const group = await ingesterProxy.getGroup(`group${i}`);
                totalAssignedGroups.push(`group${i}`);
                expect(group.isAdded).to.be.true;
                expect(group.ingesterAddresses.length <= maxIngesterPerGroup)
            }
    
            let ingesterToRemove = await ingesterProxy.getIngesterWithGroups(ingesters[0].address);
            let ingestersAllocatedCluster = BigNumber.from(ingesterToRemove.clusterId).toNumber();
            let maxGroupsPerIngesterBeforeUnregistering = await getClusterMaxGroupsPerIngester(ingesterProxy, ingestersAllocatedCluster);
    
            let ingesterRemovedAssignedGroups: string[] = ingesterToRemove.assignedGroups;
    
            await ingesterProxy.connect(ingesterToController[ingesters[0].address]).unRegisterIngester(ingesters[0].address);
    
            let clusterId = BigNumber.from(ingesterToRemove.clusterId).toNumber();
            let maxGroupsPerIngesterAfterUnregistering = await getClusterMaxGroupsPerIngester(ingesterProxy, clusterId);
            
            expect(maxGroupsPerIngesterAfterUnregistering > maxGroupsPerIngesterBeforeUnregistering);
    
            //Get the new assigned groups after unregistration
            let totalAssignedGroupsAfterUnregistration: string[] = []
            let remainingIngesters: SignerWithAddress[] = ingesters.slice(1);
            for (let j = 0; j < remainingIngesters.length; j++) {
                let ingester = await ingesterProxy.getIngesterWithGroups(remainingIngesters[j].address);
                totalAssignedGroupsAfterUnregistration = totalAssignedGroupsAfterUnregistration.concat(ingester.assignedGroups);
                expect(ingester.assignedGroups.length > maxGroupsPerIngesterBeforeUnregistering);
                expect(ingester.assignedGroups.length < maxGroupsPerIngesterAfterUnregistering);
            }
    
            //Grab unallocated groups and check if they are correctly unallocated and don't overlap with allocated groups
            let unAllocatedGroups = await ingesterProxy.getUnallocatedGroups();
            expect(unAllocatedGroups.length == 0);
    
            //check if ingester was also removed from the cluster
            let cluster = await ingesterProxy.getCluster(ingestersAllocatedCluster);
            expect(cluster.ingesterAddresses).not.include(ingesterToRemove.ingesterAddress);
        });
    
        it("should add to unassigned groups when entire cluster is removed", async () => {
            // check group assignement are within constraints
            for (let i = 0; i < numGroupsWithReplication; i++) {
                await ingesterProxy.connect(owner).addGroup(`group${i}`);
                const group = await ingesterProxy.getGroup(`group${i}`);
                expect(group.isAdded).to.be.true;
                expect(group.ingesterAddresses.length <= maxIngesterPerGroup)
            }
    
            let ingestersRemaining = ingesters;
            let clusterId = 0;
            for (let i = 0; i < maxClusterSize; i++) {
                let ingesterToRemove = await ingesterProxy.getIngesterWithGroups(ingesters[i].address);
                
                // _maxGroupsPerIngester = (numClusterGroups + numIngesters - 1) / numIngesters;
                clusterId = BigNumber.from(ingesterToRemove.clusterId).toNumber();
                let maxGroupsPerIngesterBeforeUnregistering = await getClusterMaxGroupsPerIngester(ingesterProxy, clusterId);
    
                let ingesterRemovedAssignedGroups: string[] = ingesterToRemove.assignedGroups;
                
                await ingesterProxy.connect(ingesterToController[ingesters[i].address]).unRegisterIngester(ingesters[i].address);
    
                let maxGroupsPerIngesterAfterUnregistering = await getClusterMaxGroupsPerIngester(ingesterProxy, clusterId);
    
                expect(maxGroupsPerIngesterAfterUnregistering > maxGroupsPerIngesterBeforeUnregistering);
    
                // Remove the ingester from structure
                let slicerIndex = i == 0 ? 1 : i;
                ingestersRemaining = ingestersRemaining.slice(slicerIndex);
    
                // check i remaining ingesters contain all the groups that were removed 
                let totalAssignedGroupsAfterUnregistration: string[] = []
                for (let j = 0; j < ingestersRemaining.length; j++) {
                    let ingester = await ingesterProxy.getIngesterWithGroups(ingestersRemaining[j].address);
                    totalAssignedGroupsAfterUnregistration = totalAssignedGroupsAfterUnregistration.concat(ingester.assignedGroups);
                    expect(ingester.assignedGroups.length > maxGroupsPerIngesterBeforeUnregistering);
                    expect(ingester.assignedGroups.length < maxGroupsPerIngesterAfterUnregistering);
                }
    
                //Grab unallocated groups and check if they are correctly unallocated and don't overlap with allocated groups
                let unAllocatedGroups = await ingesterProxy.getUnallocatedGroups();
                if (unAllocatedGroups.length > 0) {
                    const allocatedGroups = totalAssignedGroupsAfterUnregistration.filter(group => !unAllocatedGroups.includes(group));
                    
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

                let cluster = await ingesterProxy.getCluster(clusterId);
                expect(cluster.ingesterAddresses.length == 0);
            }
        });

        it("should allocate new groups when available to newly registered ingester", async () => {
            // check group assignement are within constraints
            let clusterIds = await ingesterProxy.getClusters();
            let totalGroupsConstraint = (clusterIds.length * maxClusterSize * maxGroupsPerIngester) / maxIngesterPerGroup;

            for (let i = 0; i < totalGroupsConstraint; i++) {
                await ingesterProxy.connect(owner).addGroup(`group${i}`);
                const group = await ingesterProxy.getGroup(`group${i}`);
                expect(group.isAdded).to.be.true;
                expect(group.ingesterAddresses.length <= maxIngesterPerGroup)
            }
    
            // use last available account as new test ingester to be registered
            let hash2 = await ingesterProxy.hash(accounts[accounts.length -1].address, message, nonce);
            const sig2 = await accounts[accounts.length - 2].signMessage(ethers.utils.arrayify(hash2));
            await ingesterProxy.connect(accounts[accounts.length - 2]).registerIngester(accounts[accounts.length - 1].address, message, nonce, sig2);
            
            // check all new incoming groups get allocated to the new ingester
            for (let i = totalGroupsConstraint; i < numGroupsWithReplication + 10; i++) {
                await ingesterProxy.connect(owner).addGroup(`group${i}`);
                const group = await ingesterProxy.getGroup(`group${i}`);
                expect(group.isAdded).to.be.true;
                expect(group.ingesterAddresses).to.include(accounts[accounts.length -1].address);
                expect(group.ingesterAddresses.length <= maxIngesterPerGroup)
    
                let newIngester = await ingesterProxy.getIngesterWithGroups(accounts[accounts.length -1].address);
                expect(newIngester.assignedGroups).to.include(`group${i}`);
            }
        });

        it("should restrict one controller wallet owning more than one ingester per cluster", async () => {
            let numIngestersToAdd = 2;
            let controllerAccount = accounts[0];
            let newIngesters: SignerWithAddress[] = [];
            for (let i = accounts.length - 1; i >= accounts.length - numIngestersToAdd; i-- ) {
                let hash = await ingesterProxy.hash(accounts[i].address, message, nonce);
                const sig = await controllerAccount.signMessage(ethers.utils.arrayify(hash));
                await ingesterProxy.connect(controllerAccount).registerIngester(accounts[i].address, message, nonce, sig);
                newIngesters.push(accounts[i]);

            }

            let controllerIngesters = await ingesterProxy.getControllerIngesters(controllerAccount.address);
            let clusterIds: number[] = [];
            for (const ingesterAccount of controllerIngesters) {
                let ingester = await ingesterProxy.getIngesterWithGroups(ingesterAccount.ingesterAddress);
                clusterIds.push(BigNumber.from(ingester.clusterId).toNumber());
            }
            expect(allUnique(clusterIds)).to.be.true;
        });

        it("should add unalloccated groups to newly registered ingester if capacity allows", async () => {
            // let maxGroupsPerCluster = numIngesters * maxGroupsPerIngester;
            let clusterIds = await ingesterProxy.getClusters();
            let totalGroupsConstraint = (clusterIds.length * maxClusterSize * maxGroupsPerIngester) / maxIngesterPerGroup;
    
    
            // Add maximum groups possible
            let totalAssignedGroups: string[] = [];
            for (let i = 0; i < totalGroupsConstraint; i++) {
                await ingesterProxy.connect(owner).addGroup(`group${i}`);
                const group = await ingesterProxy.getGroup(`group${i}`);
                totalAssignedGroups.push(`group${i}`);
                expect(group.isAdded).to.be.true;
                expect(group.ingesterAddresses.length <= maxIngesterPerGroup)
            }
    
            let ingesterToRemove = await ingesterProxy.getIngesterWithGroups(ingesters[0].address);
            let ingesterRemovedAssignedGroups: string[] = ingesterToRemove.assignedGroups;
    
            await ingesterProxy.connect(ingesterToController[ingesters[0].address]).unRegisterIngester(ingesters[0].address);
    
            expect(ingesterProxy.getIngesterWithGroups(ingesters[0].address)).to.be.revertedWith("Ingester does not exist.");
    
            //Grab unallocated groups and check if they are correctly unallocated and don't overlap with allocated groups
            let unAllocatedGroupsBeforeRegistration = await ingesterProxy.getUnallocatedGroups();
            
            //register Ingester again and check if the unallocated groups get allocated again
            let hash = await ingesterProxy.hash(ingesters[0].address, message, nonce);
            const sig = await ingesterToController[ingesters[0].address].signMessage(ethers.utils.arrayify(hash));
            await ingesterProxy.connect(ingesterToController[ingesters[0].address]).registerIngester(ingesters[0].address, message, nonce, sig);
            //Distribute groups after registration
            let ingesterBeforeDistribution = await ingesterProxy.getIngesterWithGroups(ingesters[0].address);
            let distributeTx = await ingesterProxy.connect(ingesterToController[ingesters[0].address]).distributeGroups(ingesters[0].address);
            let ingesterAfterDistribution = await ingesterProxy.getIngesterWithGroups(ingesters[0].address);
    
            //Check if unallocated groups were distributed and events were triggered
            let cluster = await ingesterGroupManager.getCluster(ingesterBeforeDistribution.clusterId);
            let clusterRemainingCapacityBeforeDistribution = BigNumber.from(cluster.clusterRemainingCapacity).toNumber();

            let ingesterWithinCluster = await ingesterProxy.getIngesterWithGroups(cluster.ingesterAddresses[0]);

            //check that the assigned groups to ingester with replication is the same as the other ingesters within cluster
            expect(ingesterWithinCluster.assignedGroups == ingesterAfterDistribution.assignedGroups);
        });
    });
  });

 
  describe('Add IPFS Hashes', function () {
    const usersHash = 'QmXx6gTFHa6mudUhKjFkNVak1q8exg68oMsCmzePJX9fKu';
    const chatsHash = 'QmS7V1ASYYkKj7V4d4QF4JZ9XKj5L5PY5pCVS5GPy7fQQn';
    const messagesHash = 'QmQe4R6UjQ6TDMDVbBopabKK46PGjKMYpHJ3qf8WdYY6gC';
  
    beforeEach(async function () {
        //Verify ingester1
        let hash = await ingesterProxy.hash(ingester1.address, message, nonce);
        const sig = await controller.signMessage(ethers.utils.arrayify(hash));
        await ingesterProxy.connect(controller).registerIngester(ingester1.address, message, nonce, sig);

        //Verify ingester2
        let hash2 = await ingesterProxy.hash(ingester2.address, message, nonce);
        const sig2 = await controller.signMessage(ethers.utils.arrayify(hash2));
        await ingesterProxy.connect(controller).registerIngester(ingester2.address, message, nonce, sig2);
    });
  
    it('should revert if called controller instead of ingester address', async function () {
        expect(
            ingesterProxy.connect(controller).addIpfsHash(
                usersHash,
                chatsHash,
                messagesHash
            )
        ).to.be.revertedWith('Only registered ingester controller can perform this action.');
    });

    it('should add the IPFS hashes to the registry and emit events', async function () {
        const txAddIpfsHash = await ingesterProxy.connect(ingester1).addIpfsHash(
            usersHash,
            chatsHash,
            messagesHash
        );
        
        const ipfsHashes = await ingesterProxy.getIpfsHashes(ingester1.address);
        //Check storage values through ipfsHash getter
        expect(ipfsHashes['usersIpfsHash']).to.equal(usersHash);
        expect(ipfsHashes['chatsIpfsHash']).to.equal(chatsHash);
        expect(ipfsHashes['messagesIpfsHash']).to.equal(messagesHash);
    });

    it('should emit events when add the IPFS hashes to the registry ', async function () {
        const txAddIpfsHash = await ingesterProxy.connect(ingester1).addIpfsHash(
            usersHash,
            chatsHash,
            messagesHash
        );
        
        //Check for emitted events
        expect(txAddIpfsHash).to.emit(ingesterProxy, "IpfsHashAdded").withArgs(ingester1.address, usersHash, chatsHash, messagesHash);
    });
});



});